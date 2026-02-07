FactoryBot.define do
  factory :base_question do
    passage
    content { "이 글의 핵심 주제는 무엇인가요?" }
    bloom_level { :remember }
    position { 0 }
  end
end
