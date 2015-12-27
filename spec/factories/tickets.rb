FactoryGirl.define do
  factory :ticket do
    user
    ticket_type
    quantity 10
  end
end
