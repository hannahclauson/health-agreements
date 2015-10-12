FactoryGirl.define do
  factory :badge_practice do
    implementation { (rand*5).to_i }
  end
end
