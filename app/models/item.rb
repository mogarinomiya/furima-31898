class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  #active_hash :category_id, :condition_id, :shipping_cost_id, :shipping_area_id, :shipping_time_id

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :province
  belongs_to :shipping_time

  with_options presence: true do
    validates :item_name
    validates :image
    validates :description
    validates :price,         format: { with: /\A\d[3-9][0-9]{2}|[1-9][0-9]{3,6}+\z/ }
    validates :user
    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :condition_id
      validates :shipping_cost_id
      validates :province_id
      validates :shipping_time_id
    end
  end

end
