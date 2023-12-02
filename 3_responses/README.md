# レスポンス内容の変更検知

## 前提

### OpenAPIの元ファイル

* petstore-expanded.yml
  * https://github.com/OAI/OpenAPI-Specification/blob/bcb0c454cc4def694840593c5d88ce4fffe3fbdd/examples/v3.0/petstore-expanded.yaml

### 作成したファイル

* before.yml
  * 2_parameters/after.yml から変更なし
* after.yml
  * 上記 before.yml から以下を変更
    * `#/components/schemas/Pet`からプロパティ`tag`を削除
    * `#/components/schemas/Pet`にプロパティ`species`を追加
    * `DELETE /pets/{id}`から`default`のレスポンス定義を削除
    * `DELETE /pets/{id}`に`400`のレスポンス定義を追加
    * `PUT /pets/{id}`に`401`のレスポンス定義を追加
    * `#/components/schemas/ConflictError`の定義を追加

<details>
<summary>diffコマンドでの差分</summary>

```
89a90,95
>         '400':
>           description: bad request
>           content:
>             application/json:
>               schema:
>                 $ref: '#/components/schemas/BadRequestError'
110,111c116,117
<         default:
<           description: unexpected error
---
>         '401':
>           description: unauthorized
115c121
<                 $ref: '#/components/schemas/Error'
---
>                 $ref: '#/components/schemas/UnauthorizedError'
129,130c135,142
<         tag:
<           type: string   
---
>         species:
>           type: enum
>           enum:
>             - cat
>             - dog
>             - fish
>             - other
>             - null
164a177,212
>       type: object
>       required:
>         - code
>         - message
>       properties:
>         code:
>           type: integer
>           format: int32
>         message:
>           type: string
> 
>     BadRequestError:
>       type: object
>       required:
>         - code
>         - message
>       properties:
>         code:
>           type: integer
>           format: int32
>         message:
>           type: string
>           
>     UnauthorizedError:
>       type: object
>       required:
>         - code
>         - message
>       properties:
>         code:
>           type: integer
>           format: int32
>         message:
>           type: string
>           
>     ConflictError:
```

</details>

## 検証

### 実行コマンド

```bash
cd /path/to/openapi-diff-tool-examination
docker build . -t diff-examination
  
cd /path/to/openapi-diff-tool-examination/3_responses
docker run --rm -v $(pwd):/app/resources -it diff-examination before.yaml after.yaml
```

### 実行結果

* `#/components/schemas/Pet`にプロパティ`species`が追加されている
* `#/components/schemas/Pet`からプロパティ`tag`が削除されている
* `DELETE /pets/{id}`に`400`のレスポンス定義が追加されている
* `DELETE /pets/{id}`から`default`のレスポンス定義が削除されている
* `PUT /pets/{id}`に`401`のレスポンス定義が追加されている
* `#/components/schemas/ConflictError`の追加が**検知・報告されていない**
  * `#/components/schemas/ConflictError`を利用するエンドポイントがないことが要因

```
### New Endpoints: None
-----------------------

### Deleted Endpoints: None
---------------------------

### Modified Endpoints: 3
-------------------------
GET /pets
- Responses changed
  - Modified response: 200
    - Content changed
      - Modified media type: application/json
        - Schema changed
          - Items changed
            - Properties changed
              - New property: species
              - Deleted property: tag

DELETE /pets/{id}
- Responses changed
  - New response: 401
  - Deleted response: default

PUT /pets/{id}
- Responses changed
  - New response: 400
  - Modified response: 200
    - Content changed
      - Modified media type: application/json
        - Schema changed
          - Properties changed
            - New property: species
            - Deleted property: tag
```
