users テーブル

| email              | string | null: false,unique: true |
| encrypted_password | string | null: false|
| name               | string | null: false|
| profile            | text   | null: false|
| occupation         | text   | null: false|
| position           | text   | null: false|

comments テーブル

| content   | text       | null: false |
| prototype | references | null: false,foreign_key: true|
| user      | references | null: false,foreign_key: true|

prototypes テーブル|
| title      | string     | null: false|
| catch_copy | text       | null: false|
| concept    | text       | null: false,foreign_key: true|
| user       | references | null: false|