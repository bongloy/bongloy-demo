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
    token { Bongloy::SpecHelpers::ApiHelpers.new.generate_uuid }
  end

  factory :checkout_configuration do
    trait :custom do
      currency "USD"
      amount_cents 500
      name "My Shop"
      description "My Custom Description"
      product_description "My Product Description"
      label "My Label"
    end
  end
end
