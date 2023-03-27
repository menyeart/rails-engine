FactoryBot.define do
  factory :merchant do
    name { Faker::Name.name }
    # item { create(:item) } if you want to created nested things(has/belings to)

  end
end
