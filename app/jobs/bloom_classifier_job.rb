class BloomClassifierJob < ApplicationJob
  queue_as :default

  def perform(student_question_id)
    question = StudentQuestion.find(student_question_id)
    level = BloomClassifier.new(question.content).call
    question.update!(bloom_level: level)
  end
end
