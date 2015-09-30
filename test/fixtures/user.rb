FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { '12345' }
    password_confirmation { '12345' }
    role 'editor'

    trait :admin do
      role 'admin'
    end
  end
end
