FactoryGirl.define do
  factory :event do
    name { Faker::Commerce.product_name }
    extended_html_description { Faker::Lorem.sentence }
    starts_at { 2.days.ago }
    ends_at { DateTime.current }
    category
    venue
  end

end
