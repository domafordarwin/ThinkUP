FactoryBot.define do
  factory :activity_report do
    report_type { :student_report }
    association :user, factory: :user
    association :generated_by, factory: [:user, :diagnosis_admin]
    data { { total_sessions: 5, bloom_distribution: { "remember" => 2, "analyze" => 3 } } }
    period_start { 1.month.ago.to_date }
    period_end { Date.current }

    trait :school_report do
      report_type { :school_report }
      user { nil }
      school
    end

    trait :overall_report do
      report_type { :overall_report }
      user { nil }
      school { nil }
    end
  end
end
