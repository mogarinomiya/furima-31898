Faker::Config.locale = :ja

FactoryBot.define do
  factory :item do
    item_name             {Faker::Book.title}
    description           {Faker::Lorem.sentence}
    category_id           {Faker::Number.between(from: 2, to: 11)}
    condition_id          {Faker::Number.between(from: 2, to: 7)}
    shipping_cost_id      {Faker::Number.between(from: 2, to: 3)}
    province_id           {Faker::Number.between(from: 2, to: 48)}
    shipping_time_id      {Faker::Number.between(from: 2, to: 4)}
    price                 {Faker::Number.between(from: 300, to: 9999999)}
    association           :user
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test.jpg'), filename: 'test_image.jpg')
    end
  end
end
