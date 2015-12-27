FactoryGirl.define do
  factory :ticket do
    user
    event
    quantity 1000
  end
end
