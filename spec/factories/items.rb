FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence(word_count: 6) }
    unit_price { Faker::Number.decimal(l_digits: 2) }
  end
end
