Faker::Config.locale = :ja

FactoryBot.define do
  factory :user do
    transient do
      name { Gimei.name }
    end
    nickname              { Faker::Internet.user_name }
    email                 { Faker::Internet.unique.free_email }
    password              { Faker::Internet.password(min_length: 4, max_length: 18) + 'a1' }
    # ↑たまに英数の条件を満たさないので強制的にa1を付加。
    password_confirmation { password }
    first_name            { name.first.kanji }
    last_name             { name.last.kanji }
    first_name_read       { name.first.katakana }
    last_name_read        { name.last.katakana }
    birthday              { Faker::Date.birthday(min_age: 18, max_age: 65).strftime('%Y-%m-%d') }
  end
end
