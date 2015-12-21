FactoryGirl.define do
  factory :ticket_type do
    name { ["courtside", "vip", "premium", "standard"] }
    price { Faker::Number.number(5) }
    max_quantity { Faker::Number. }
  end

end
