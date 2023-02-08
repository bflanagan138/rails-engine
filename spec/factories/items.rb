FactoryBot.define do
  factory :item do
    name { Faker::Nation.nationality }
    description { Faker::Nation.language }
    unit_price { Faker::Nation.capital_city }
    merchant
  end
end