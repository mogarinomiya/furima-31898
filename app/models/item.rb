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
      validates :category_id, numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 11 }
      validates :condition_id, numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 7 }
      validates :shipping_cost_id, numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 3 }
      validates :province_id, numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 48 }
      validates :shipping_time_id, numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 4 }
    end
  end

end
