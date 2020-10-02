# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## users テーブル

| Column    | Type    | Options     |
| --------  | ------  | ----------- |
| name      | string  | null: false |
| email     | string  | null: false |
| password  | string  | null: false |

 
### Association

- has_many :posts
- has_many :comments
- has_many :likes


## posts テーブル
 
| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user        | references | null: false, foreign_key: true |
| name        | string     | null: false                    |
| description | text       | null: false                    |
| image       | string     | null: false                    |
| cc_id       | integer    | null: false                    |  
| maker_id    | integer    | null: false                    |
| type_id     | integer    | null: false                    |

### Association

- belongs_to :user
- has_many :likes
- has_many :comments


## comments テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false, foreign_key: true |
| post     | references | null: false, foreign_key: true |
| comment  | text       | null: false                    |

### Association

- belongs_to :user
- belongs_to :post


## likes テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| post   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post