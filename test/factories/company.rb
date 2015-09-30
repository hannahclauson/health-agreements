FactoryGirl.define do
  factory :company do
    name { Faker::Company.name }
    description { Faker::Company.bs }
    url { Faker::Internet.url }
  end
end
