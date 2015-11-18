FactoryGirl.define do
  factory :guide do
    sequence(:name) {|n| "user#{n}" }
    email { "#{name}@example.com" }
    password Faker::Internet.password(8)
  end
end
