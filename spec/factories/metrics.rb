FactoryBot.define do
  factory :metric do
    name { Faker::Lorem.word }
    value { Faker::Number.decimal(l_digits: 2) }
  end
end
