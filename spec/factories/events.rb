FactoryGirl.define do
  factory :event do
    name { Faker::Name.name }
    extended_html_description { Faker::Lorem.sentence }
    starts_at { 2.days.ago }
    ends_at { DateTime.current }
    category
    venue

    trait :past do
      ends_at { 1.day.ago }
    end

    trait :up_comming do
      ends_at { 2.days.from_now }
    end
  end
end
