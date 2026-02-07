FactoryBot.define do
  factory :student_question do
    learning_session
    content { "저자는 왜 이런 주장을 했을까요?" }
    bloom_level { :analyze }
  end
end
