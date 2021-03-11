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
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
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
