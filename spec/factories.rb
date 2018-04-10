FactoryBot.define do
  factory :user do
    name "Name Namerson"
    sequence(:email) { |n| "email#{n}@email.com" }
    password "Password"
    password_confirmation "Password"
  end

  factory :level do
    level_number 1
  end

  factory :score do
    completion_time { 1 + rand(100) }
    user
    level
  end

  factory :block do
    nickname 't_block'
  end

  factory :solution do
    nickname 'solution1'
  end
end

