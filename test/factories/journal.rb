FactoryGirl.define do
  factory :journal do
    name { Faker::Company.name }
    impact_factor { Faker::Number.positive(0.0,100.0) }
    url { Faker::Internet.url }
  end
end
