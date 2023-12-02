# リクエスト内容の変更検知

## 前提

### OpenAPIの元ファイル

* petstore-expanded.yml
  * https://github.com/OAI/OpenAPI-Specification/blob/bcb0c454cc4def694840593c5d88ce4fffe3fbdd/examples/v3.0/petstore-expanded.yaml

### 作成したファイル

* before.yml
  * 1_endpoints/after.yml から以下を変更
    * `#/components/schemas/Pet`が`#/components/schemas/NewPet`へ依存させない
    * `#/components/schemas/ModifiedPet`にパラメータ`species`を追加
* after.yml
  * 上記 before.yml から以下を変更
    * `GET /pets`にクエリパラメータ`offset`を追加
    * `GET /pets`のクエリパラメータ`limit`のformatを`int64`に変更
    * `#/components/schemas/NewPet`にパラメータ`species`を追加
    * `#/components/schemas/NewPet`からパラメータ`tag`を削除
    * `#/components/schemas/ModifiedPet`からパラメータ`tag`を削除
    * `#/components/schemas/ModifiedPet`のパラメータ`species`のenum定数`fish`を追加

<details>
<summary>diffコマンドでの差分</summary>

```
34a35,41
>         - name: offset
>           in: query
>           description: offset to start from
>           required: false
>           schema:
>             type: integer
>             format: int64
41c48
<             format: int32
---
>             format: int64
115c122
<         - name
---
>         - name  
123c130
<           type: string
---
>           type: string   
132,133c139,146
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
142,143d154
<         tag:
<           type: string    
148a160
>             - fish
```

</details>

## 検証

### 実行コマンド

```bash
cd /path/to/openapi-diff-diff-tool-examination
docker build . -t diff-examination
  
cd /path/to/openapi-diff-tool-examination/2_parameters
docker run --rm -v $(pwd):/app/resources -it diff-examination before.yaml after.yaml
```

### 実行結果

* `GET /pets`にクエリパラメータ`offset`が追加されている
* `GET /pets`のクエリパラメータ`limit`のformatが`int64`に変更されている
* `#/components/schemas/ModifiedPet`からパラメータ`tag`が削除されている
* `#/components/schemas/ModifiedPet`のパラメータ`species`のenum定数`fish`が追加されている
* `#/components/schemas/NewPet`の変更が**検知・報告されていない**
  * `#/components/schemas/NewPet`を利用するエンドポイントがないことが要因

```
### New Endpoints: None
-----------------------

### Deleted Endpoints: None
---------------------------

### Modified Endpoints: 2
-------------------------
GET /pets
- New query param: offset
- Modified query param: limit
  - Schema changed
    - Format changed from 'int32' to 'int64'

PUT /pets/{id}
- Request body changed
  - Content changed
    - Modified media type: application/json
      - Schema changed
        - Properties changed
          - Deleted property: tag
          - Modified property: species
            - New enum values: [fish]
```
