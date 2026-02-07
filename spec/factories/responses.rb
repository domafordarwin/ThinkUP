FactoryBot.define do
  factory :response do
    learning_session
    base_question
    content { "이 글의 주제는 환경 보호입니다." }
  end
end
