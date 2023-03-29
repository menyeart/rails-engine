FactoryBot.define do
  factory :invoice do
    status { Faker::Verb.base }
  end
end