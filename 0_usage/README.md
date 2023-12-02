
## 前提

### OpenAPIの元ファイル

* petstore.yml
  * https://github.com/OAI/OpenAPI-Specification/blob/bcb0c454cc4def694840593c5d88ce4fffe3fbdd/examples/v3.0/petstore.yaml
* petstore-expanded.yml
  * https://github.com/OAI/OpenAPI-Specification/blob/bcb0c454cc4def694840593c5d88ce4fffe3fbdd/examples/v3.0/petstore-expanded.yaml

### 単純な diff コマンドで比較

#### 実行コマンド

```bash
cd /path/to/openapi-diff-tool-examination/0_usage
diff petstore.yaml petstore-expanded.yaml
```

#### 実行結果

<deitals>
<summary>まともに見れないので折りたたみ</summary>

```
4a5,10
>   description: A sample API that uses a petstore as an example to demonstrate features in the OpenAPI 3.0 specification
>   termsOfService: http://swagger.io/terms/
>   contact:
>     name: Swagger API Team
>     email: apiteam@swagger.io
>     url: http://swagger.io
6c12,13
<     name: MIT
---
>     name: Apache 2.0
>     url: https://www.apache.org/licenses/LICENSE-2.0.html
8c15
<   - url: http://petstore.swagger.io/v1
---
>   - url: https://petstore.swagger.io/v2
12,15c19,24
<       summary: List all pets
<       operationId: listPets
<       tags:
<         - pets
---
>       description: |
>         Returns all pets from the system that the user has access to
>         Nam sed condimentum est. Maecenas tempor sagittis sapien, nec rhoncus sem sagittis sit amet. Aenean at gravida augue, ac iaculis sem. Curabitur odio lorem, ornare eget elementum nec, cursus id lectus. Duis mi turpis, pulvinar ac eros ac, tincidunt varius justo. In hac habitasse platea dictumst. Integer at adipiscing ante, a sagittis ligula. Aenean pharetra tempor ante molestie imperdiet. Vivamus id aliquam diam. Cras quis velit non tortor eleifend sagittis. Praesent at enim pharetra urna volutpat venenatis eget eget mauris. In eleifend fermentum facilisis. Praesent enim enim, gravida ac sodales sed, placerat id erat. Suspendisse lacus dolor, consectetur non augue vel, vehicula interdum libero. Morbi euismod sagittis libero sed lacinia.
> 
>         Sed tempus felis lobortis leo pulvinar rutrum. Nam mattis velit nisl, eu condimentum ligula luctus nec. Phasellus semper velit eget aliquet faucibus. In a mattis elit. Phasellus vel urna viverra, condimentum lorem id, rhoncus nibh. Ut pellentesque posuere elementum. Sed a varius odio. Morbi rhoncus ligula libero, vel eleifend nunc tristique vitae. Fusce et sem dui. Aenean nec scelerisque tortor. Fusce malesuada accumsan magna vel tempus. Quisque mollis felis eu dolor tristique, sit amet auctor felis gravida. Sed libero lorem, molestie sed nisl in, accumsan tempor nisi. Fusce sollicitudin massa ut lacinia mattis. Sed vel eleifend lorem. Pellentesque vitae felis pretium, pulvinar elit eu, euismod sapien.
>       operationId: findPets
16a26,34
>         - name: tags
>           in: query
>           description: tags to filter by
>           required: false
>           style: form
>           schema:
>             type: array
>             items:
>               type: string
19c37
<           description: How many items to return at one time (max 100)
---
>           description: maximum number of results to return
23d40
<             maximum: 100
27,32c44
<           description: A paged array of pets
<           headers:
<             x-next:
<               description: A link to the next page of responses
<               schema:
<                 type: string
---
>           description: pet response
34c46
<             application/json:    
---
>             application/json:
36c48,50
<                 $ref: "#/components/schemas/Pets"
---
>                 type: array
>                 items:
>                   $ref: '#/components/schemas/Pet'
42c56
<                 $ref: "#/components/schemas/Error"
---
>                 $ref: '#/components/schemas/Error'
44,47c58,66
<       summary: Create a pet
<       operationId: createPets
<       tags:
<         - pets
---
>       description: Creates a new pet in the store. Duplicates are allowed
>       operationId: addPet
>       requestBody:
>         description: Pet to add to the store
>         required: true
>         content:
>           application/json:
>             schema:
>               $ref: '#/components/schemas/NewPet'
49,50c68,73
<         '201':
<           description: Null response
---
>         '200':
>           description: pet response
>           content:
>             application/json:
>               schema:
>                 $ref: '#/components/schemas/Pet'
56,57c79,80
<                 $ref: "#/components/schemas/Error"
<   /pets/{petId}:
---
>                 $ref: '#/components/schemas/Error'
>   /pets/{id}:
59,62c82,83
<       summary: Info for a specific pet
<       operationId: showPetById
<       tags:
<         - pets
---
>       description: Returns a user based on a single ID, if the user does not have access to the pet
>       operationId: find pet by id
64c85
<         - name: petId
---
>         - name: id
65a87
>           description: ID of pet to fetch
67d88
<           description: The id of the pet to retrieve
69c90,91
<             type: string
---
>             type: integer
>             format: int64
72c94
<           description: Expected response to a valid request
---
>           description: pet response
76c98
<                 $ref: "#/components/schemas/Pet"
---
>                 $ref: '#/components/schemas/Pet'
82c104,124
<                 $ref: "#/components/schemas/Error"
---
>                 $ref: '#/components/schemas/Error'
>     delete:
>       description: deletes a single pet based on the ID supplied
>       operationId: deletePet
>       parameters:
>         - name: id
>           in: path
>           description: ID of pet to delete
>           required: true
>           schema:
>             type: integer
>             format: int64
>       responses:
>         '204':
>           description: pet deleted
>         default:
>           description: unexpected error
>           content:
>             application/json:
>               schema:
>                 $ref: '#/components/schemas/Error'
85a128,138
>       allOf:
>         - $ref: '#/components/schemas/NewPet'
>         - type: object
>           required:
>           - id
>           properties:
>             id:
>               type: integer
>               format: int64
> 
>     NewPet:
88,89c141
<         - id
<         - name
---
>         - name  
91,93d142
<         id:
<           type: integer
<           format: int64
97,102c146,147
<           type: string
<     Pets:
<       type: array
<       maxItems: 100
<       items:
<         $ref: "#/components/schemas/Pet"
---
>           type: string    
> 
```

</detials>


## 使い方

### 単純な比較

#### 実行コマンド

```bash
cd /path/to/openapi-diff-tool-examination
docker build . -t diff-examination

cd /path/to/openapi-diff-tool-examination/0_usage
docker run --rm -v $(pwd):/app/resources -it diff-examination petstore.yaml petstore-expanded.yaml
```

#### 実行結果

* まともに見れる量ではないが、うまく差分が検知できていそう
* 詳細な差分パターンが検知できるかは別項目で調査

```
### New Endpoints: 1
--------------------
DELETE /pets/{petId}  

### Deleted Endpoints: None
---------------------------

### Modified Endpoints: 3
-------------------------
GET /pets
- Description changed from '' to 'Returns all pets from the system that the user has access to
Nam sed condimentum est. Maecenas tempor sagittis sapien, nec rhoncus sem sagittis sit amet. Aenean at gravida augue, ac iaculis sem. Curabitur odio lorem, ornare eget elementum nec, cursus id lectus. Duis mi turpis, pulvinar ac eros ac, tincidunt varius justo. In hac habitasse platea dictumst. Integer at adipiscing ante, a sagittis ligula. Aenean pharetra tempor ante molestie imperdiet. Vivamus id aliquam diam. Cras quis velit non tortor eleifend sagittis. Praesent at enim pharetra urna volutpat venenatis eget eget mauris. In eleifend fermentum facilisis. Praesent enim enim, gravida ac sodales sed, placerat id erat. Suspendisse lacus dolor, consectetur non augue vel, vehicula interdum libero. Morbi euismod sagittis libero sed lacinia.

Sed tempus felis lobortis leo pulvinar rutrum. Nam mattis velit nisl, eu condimentum ligula luctus nec. Phasellus semper velit eget aliquet faucibus. In a mattis elit. Phasellus vel urna viverra, condimentum lorem id, rhoncus nibh. Ut pellentesque posuere elementum. Sed a varius odio. Morbi rhoncus ligula libero, vel eleifend nunc tristique vitae. Fusce et sem dui. Aenean nec scelerisque tortor. Fusce malesuada accumsan magna vel tempus. Quisque mollis felis eu dolor tristique, sit amet auctor felis gravida. Sed libero lorem, molestie sed nisl in, accumsan tempor nisi. Fusce sollicitudin massa ut lacinia mattis. Sed vel eleifend lorem. Pellentesque vitae felis pretium, pulvinar elit eu, euismod sapien.
'
- New query param: tags
- Modified query param: limit
  - Description changed from 'How many items to return at one time (max 100)' to 'maximum number of results to return'
  - Schema changed
    - Max changed from 100 to null
- Responses changed
  - Modified response: 200
    - Description changed from 'A paged array of pets' to 'pet response'
    - Content changed
      - Modified media type: application/json
        - Schema changed
          - MaxItems changed from 100 to null
          - Items changed
            - Property 'AllOf' changed
              - Schemas added: [NewPet RevisionSchema[1]]
            - Type changed from 'object' to ''
            - Required changed
              - Deleted required property: id
              - Deleted required property: name
            - Properties changed
              - Deleted property: id
              - Deleted property: name
              - Deleted property: tag
    - Headers changed
      - Deleted header: x-next

POST /pets
- Description changed from '' to 'Creates a new pet in the store. Duplicates are allowed'
- Request body changed
- Responses changed
  - New response: 200
  - Deleted response: 201

GET /pets/{petId}
- Description changed from '' to 'Returns a user based on a single ID, if the user does not have access to the pet'
- Modified path param: petId
  - Description changed from 'The id of the pet to retrieve' to 'ID of pet to fetch'
  - Schema changed
    - Type changed from 'string' to 'integer'
    - Format changed from '' to 'int64'
- Responses changed
  - Modified response: 200
    - Description changed from 'Expected response to a valid request' to 'pet response'
    - Content changed
      - Modified media type: application/json
        - Schema changed
          - Property 'AllOf' changed
            - Schemas added: [NewPet RevisionSchema[1]]
          - Type changed from 'object' to ''
          - Required changed
            - Deleted required property: id
            - Deleted required property: name
          - Properties changed
            - Deleted property: id
            - Deleted property: name
            - Deleted property: tag

Servers changed
- New server: https://petstore.swagger.io/v2
- Deleted server: http://petstore.swagger.io/v1
```

### 差分確認箇所の限定

#### 特定要素の差分を無視する

* `--exclude-elements`にカンマ区切りで指定可能
* `v1.10.0`現在で除外可能な要素は `examples`,`description`,`summary`,`title`,`endpoints`
  * `endpoints`は出力形式がyamlのときのみ有効な模様

##### 実行コマンド

```diff
  cd /path/to/openapi-diff-tool-examination
  docker build . -t diff-examination
  
  cd /path/to/openapi-diff-tool-examination/0_usage
- docker run --rm -v $(pwd):/app/resources -it diff-examination petstore.yaml petstore-expanded.yaml
+ docker run --rm -v $(pwd):/app/resources -it diff-examination petstore.yaml petstore-expanded.yaml --exclude-elements description
```

##### 実行結果

* `description`の差分が報告されなくなっている

```
### New Endpoints: 1
--------------------
DELETE /pets/{petId}  

### Deleted Endpoints: None
---------------------------

### Modified Endpoints: 3
-------------------------
GET /pets
- New query param: tags
- Modified query param: limit
  - Schema changed
    - Max changed from 100 to null
- Responses changed
  - Modified response: 200
    - Content changed
      - Modified media type: application/json
        - Schema changed
          - MaxItems changed from 100 to null
          - Items changed
            - Property 'AllOf' changed
              - Schemas added: [NewPet RevisionSchema[1]]
            - Type changed from 'object' to ''
            - Required changed
              - Deleted required property: id
              - Deleted required property: name
            - Properties changed
              - Deleted property: id
              - Deleted property: name
              - Deleted property: tag
    - Headers changed
      - Deleted header: x-next

POST /pets
- Request body changed
- Responses changed
  - New response: 200
  - Deleted response: 201

GET /pets/{petId}
- Modified path param: petId
  - Schema changed
    - Type changed from 'string' to 'integer'
    - Format changed from '' to 'int64'
- Responses changed
  - Modified response: 200
    - Content changed
      - Modified media type: application/json
        - Schema changed
          - Property 'AllOf' changed
            - Schemas added: [NewPet RevisionSchema[1]]
          - Type changed from 'object' to ''
          - Required changed
            - Deleted required property: id
            - Deleted required property: name
          - Properties changed
            - Deleted property: id
            - Deleted property: name
            - Deleted property: tag

Servers changed
- New server: https://petstore.swagger.io/v2
- Deleted server: http://petstore.swagger.io/v1
```

#### 特定エンドポイントの差分`以外`を無視

* `--match-path`に正規表現で指定
* 今回選んだサンプルはエンドポイントの数が少なく分かりづらい...
  * `/pets`は除外し`/pets/`のみを対象としてみる

##### 実行コマンド


```diff
  cd /path/to/openapi-diff-tool-examination
  docker build . -t diff-examination
  
  cd /path/to/openapi-diff-tool-examination/0_usage
- docker run --rm -v $(pwd):/app/resources -it diff-examination petstore.yaml petstore-expanded.yaml --exclude-elements description
+ docker run --rm -v $(pwd):/app/resources -it diff-examination petstore.yaml petstore-expanded.yaml --exclude-elements description --match-path '/pets/'
```

##### 実行結果

* `GET /pets`、`Post /pets`の差分が報告されなくなっている
* `PUT /pets/{petId}`の差分は引き続き報告されている

```
### New Endpoints: 1
--------------------
DELETE /pets/{petId}  

### Deleted Endpoints: None
---------------------------

### Modified Endpoints: 1
-------------------------
GET /pets/{petId}
- Modified path param: petId
  - Schema changed
    - Type changed from 'string' to 'integer'
    - Format changed from '' to 'int64'
- Responses changed
  - Modified response: 200
    - Content changed
      - Modified media type: application/json
        - Schema changed
          - Property 'AllOf' changed
            - Schemas added: [NewPet RevisionSchema[1]]
          - Type changed from 'object' to ''
          - Required changed
            - Deleted required property: id
            - Deleted required property: name
          - Properties changed
            - Deleted property: id
            - Deleted property: name
            - Deleted property: tag

Servers changed
- New server: https://petstore.swagger.io/v2
- Deleted server: http://petstore.swagger.io/v1
```
