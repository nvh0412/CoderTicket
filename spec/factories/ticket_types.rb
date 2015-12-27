FactoryGirl.define do
  factory :ticket_type do
    name { ["courtside", "vip", "premium", "standard"].sample }
    price { Faker::Number.number(5) }
    max_quantity { Faker::Number.number(1) }
  end
end
