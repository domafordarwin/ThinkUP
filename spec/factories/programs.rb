FactoryBot.define do
  factory :program do
    name { "2026 사고력 증진 프로그램" }
    description { "블룸의 택소노미 기반 사고력 훈련 프로그램" }
    target_grade_min { 3 }
    target_grade_max { 6 }
    starts_on { Date.current }
    ends_on { 3.months.from_now }
  end
end
