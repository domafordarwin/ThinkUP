FactoryBot.define do
  factory :parent_student do
    association :parent, factory: [:user, :parent]
    association :student, factory: :user
  end
end
