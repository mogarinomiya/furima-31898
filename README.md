# テーブル設計

## users テーブル

| Column         | Type   | Options     |
| -------------- | ------- | ----------- |
| nickname       | string  | null: false |
| email          | string  | null: false |
| password       | string  | null: false |
| name           | string  | null: false |
| name_read      | string  | null: false |
| birthday       | date    | null: false |


### Association

- has_many :items, through: items
- has_many :order
  orderは、本来なら住所などを別テーブルに切り出してhas_oneを使うべきかと思う。
  今回はユーザー情報更新画面を作らない（サンプルにないので実装しないのだと思う）ので、has_many。

## items テーブル

| Column          | Type       | Options                        |
| --------------  | ------     | ------------------------------ |
| item_name       | string     | null: false                    |
| description     | text       | null: false                    |
| condition       | string     | null: false                    |
| shipping_cost   | string     | null: false                    |
| shipping_area   | string     | null: false                    |
| shipping_time   | string     | null: false                    |
| price           | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order
- has_one_attached :image

## order テーブル
  住所は、変更しないことを考えれば結合して登録すればいいのでひとつのカラムで管理。

| Column                | Type       | Options                        |
| ----------------      | ---------- | ------------------------------ |
| order_date            | string     | null: false                    |
| postal_code           | string     | null: false                    |
| address               | string     | null: false                    |
| phone_number          | string     | null: false                    |
| user                  | references | null: false, foreign_key: true |
| items                 | references | null: false, foreign_key: true |

- belong_to :user
- belong_to :items

