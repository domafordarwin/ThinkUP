FactoryBot.define do
  factory :session_summary do
    learning_session
    summary { "이번 세션에서 분석 수준의 발문을 2개 생성했습니다." }
    bloom_distribution { { "remember" => 1, "analyze" => 2 } }
    competency_scores { { "comprehension" => 3, "aesthetic" => 2, "communication" => 4 } }
    highlight_question { "저자는 왜 이런 주장을 했을까요?" }
  end
end
