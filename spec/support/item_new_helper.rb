module ItemNewHelpers
  def item_new(item)
    # 入力データの準備
    image_path = Rails.root.join('public/images/test.jpg')
    category = Category.find(item.category_id).name
    condition = Condition.find(item.condition_id).name
    shipping_cost = ShippingCost.find(item.shipping_cost_id).name
    province = Province.find(item.province_id).name
    shipping_time = ShippingTime.find(item.shipping_time_id).name
    # 商品の情報を入力する
    attach_file 'item[image]', image_path
    fill_in 'item-name',       with: item.item_name
    fill_in 'item-info',       with: item.description
    select category,           from: "item-category"
    select condition,          from: 'item-sales-status'
    select shipping_cost,      from: 'item-shipping-fee-status'
    select province,           from: 'item-prefecture'
    select shipping_time,      from: 'item-scheduled-delivery'
    fill_in 'item-price',      with: item.price
  end
end