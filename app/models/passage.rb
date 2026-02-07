class Passage < ApplicationRecord
  has_many :base_questions, dependent: :destroy

  enum :genre, { textbook: 0, non_fiction: 1, literature: 2 }

  validates :title, presence: true
  validates :content, presence: true
  validates :min_grade, presence: true
  validates :max_grade, presence: true

  scope :for_student, ->(grade_level:) {
    where("min_grade <= ? AND max_grade >= ?", grade_level, grade_level)
  }
end
