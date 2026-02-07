FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { "password123" }
    role { :student }
    grade_level { rand(1..12) }
    thinking_level { 1 }

    trait :parent do
      role { :parent }
      grade_level { nil }
    end

    trait :school_admin do
      role { :school_admin }
      grade_level { nil }
    end

    trait :diagnosis_admin do
      role { :diagnosis_admin }
      grade_level { nil }
    end

    trait :developer do
      role { :developer }
      grade_level { nil }
    end

    trait :system_admin do
      role { :system_admin }
      grade_level { nil }
    end
  end
end
