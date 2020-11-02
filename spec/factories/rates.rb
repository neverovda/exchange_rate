FactoryBot.define do
  factory :rate do
    value { 100 }

    trait :forced do
      forced { true }
      expiration_at { Time.now + 1.hour }
    end

    trait :forced_not_actual do
      forced { true }
      expiration_at { Time.now - 1.hour }
    end

    trait :forced_invalid do
      value { nil }
      expiration_at { Time.now - 1.hour }
    end
  end
end
