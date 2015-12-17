FactoryGirl.define do
  factory :category do
    name { ['Entertainment', 'Learning', 'Everything Else'].sample }
  end

end
