FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.words(8).join(" ") }
    summary_url { Faker::Internet.url }
    download_url { Faker::Internet.url }
  end
end


