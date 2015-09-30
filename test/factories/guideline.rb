FactoryGirl.define do
  factory :guideline do
    name { Faker::Name.name }
    description { Faker::Lorem.words }
    true_description { Faker::Lorem.words }
    false_description { Faker::Lorem.words }
  end
end
