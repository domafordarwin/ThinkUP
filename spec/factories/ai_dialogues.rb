FactoryBot.define do
  factory :ai_dialogue do
    student_question
    role { :ai_prompt }
    content { "그 질문을 던진 이유는 무엇인가요?" }
    position { 0 }
  end
end
