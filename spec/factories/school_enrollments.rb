FactoryBot.define do
  factory :school_enrollment do
    school
    user
    role_in_school { :student_member }

    trait :as_admin do
      association :user, factory: [:user, :school_admin]
      role_in_school { :admin_member }
    end

    trait :as_parent do
      association :user, factory: [:user, :parent]
      role_in_school { :parent_member }
    end
  end
end
