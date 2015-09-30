FactoryGirl.define do
  factory :badge do
    name { Faker::Name.name }
    description { Faker::Lorem.words }
  end
end
