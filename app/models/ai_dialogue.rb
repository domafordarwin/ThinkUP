class AiDialogue < ApplicationRecord
  belongs_to :student_question

  enum :role, { ai_prompt: 0, student_reply: 1 }

  validates :content, presence: true

  default_scope { order(:position) }
end
