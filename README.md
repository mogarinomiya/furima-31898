# テーブル設計

## users テーブル

| Column             | Type    | Options                  |
| --------------     | ------- | -----------              |
| nickname           | string  | null: false              |
| email              | string  | null: false, unique:true |
| password           | string  | null: false              |
| encrypted_password | string  | null: false              |
| first_name         | string  | null: false              |
| lust_name          | string  | null: false              |
| first_name_read    | string  | null: false              |
| lust_name_read     | string  | null: false              |
| birthday           | date    | null: false              |


### Association

- has_many :items
- has_many :addresses

## items テーブル

| Column           | Type       | Options                        |
| --------------   | ------     | ------------------------------ |
| item_name        | string     | null: false                    |
| image            | integer    | null: false                    |
| description      | text       | null: false                    |
| condition        | string     | null: false                    |
| shipping_cost_id | integer    | null: false                    |
| shipping_area_id | integer    | null: false                    |
| shipping_time_id | integer    | null: false                    |
| price            | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :address
- has_one_attached :image
- active_hash :shipping_cost_id, :shipping_area_id, shipping_time_id

## address テーブル
  住所は、変更しないことを考えれば結合して登録すればいいのでひとつのカラムで管理。

| Column                | Type       | Options                        |
| ----------------      | ---------- | ------------------------------ |
| address_date          | string     | null: false                    |
| postal_code           | string     | null: false                    |
| address               | string     | null: false                    |
| phone_number          | string     | null: false                    |
| order                 | references | null: false, foreign_key: true |

### Association

- belong_to :user
- belong_to :item
- has_one :order



## order テーブル

| Column                | Type       | Options                        |
| ----------------      | ---------- | ------------------------------ |
| user                  | references | null: false, foreign_key: true |
| item                  | references | null: false, foreign_key: true |

### Association

- belong_to :user
- belong_to :address

