FactoryGirl.define do
  factory :user do
    name "Name Namerson"
    sequence(:email) { |n| "email#{n}@email.com" }
    password "Password"
    password_confirmation "Password"
  end

  factory :level do

  end

  factory :score do
    user
    level
  end
end

