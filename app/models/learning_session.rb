class LearningSession < ApplicationRecord
  belongs_to :user
  belongs_to :passage
  has_many :responses, dependent: :destroy
  has_many :student_questions, dependent: :destroy

  enum :status, {
    in_progress: 0,
    base_completed: 1,
    questioning: 2,
    dialogue_active: 3,
    completed: 4
  }
end
