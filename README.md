# テーブル設計

## users テーブル

| Column             | Type    | Options                  |
| --------------     | ------- | -----------              |
| nickname           | string  | null: false              |
| email              | string  | null: false, unique:true |
| encrypted_password | string  | null: false              |
| first_name         | string  | null: false              |
| last_name          | string  | null: false              |
| first_name_read    | string  | null: false              |
| last_name_read     | string  | null: false              |
| birthday           | date    | null: false              |


### Association

- has_many :items
- has_many :orders

## items テーブル

| Column           | Type       | Options                        |
| --------------   | ------     | ------------------------------ |
| item_name        | string     | null: false                    |
| description      | text       | null: false                    |
| category_id      | integer    | null: false                    |
| condition_id     | integer    | null: false                    |
| shipping_cost_id | integer    | null: false                    |
| shipping_area_id | integer    | null: false                    |
| shipping_time_id | integer    | null: false                    |
| price            | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order
- has_one_attached :image
- active_hash :category_id, condition_id, shipping_cost_id, :shipping_area_id, shipping_time_id

## address テーブル

| Column                | Type       | Options                        |
| ----------------      | ---------- | ------------------------------ |
| postal_code           | string     | null: false                    |
| province_id           | integer    | null: false                    |
| city                  | string     | null: false                    |
| address               | string     | null: false                    |
| building_name         | string     |                                |
| phone_number          | string     | null: false                    |
| order                 | references | null: false, foreign_key: true |

### Association

- belong_to :order
- active_hash :province_id


## order テーブル

| Column                | Type       | Options                        |
| ----------------      | ---------- | ------------------------------ |
| user                  | references | null: false, foreign_key: true |
| item                  | references | null: false, foreign_key: true |

### Association

- belong_to :item
- belong_to :user
- has_one :address

