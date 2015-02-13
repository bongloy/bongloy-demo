FactoryGirl.define do
  sequence :email do |n|
    "someone#{n}@example.com"
  end

  factory :user do
    email
    password "secret123"
  end

  factory :charge do
    skip_create

    amount 2000
    currency "usd"
    token { Bongloy::SpecHelpers::ApiHelpers.new.sample_token_id }
  end
end
