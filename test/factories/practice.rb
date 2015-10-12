FactoryGirl.define do
  factory :practice do
    notes { Faker::Lorem.words }
    implementation { (rand*5).to_i }
  end
end
