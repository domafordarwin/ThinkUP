class Passage < ApplicationRecord
  has_many :base_questions, dependent: :destroy
  belongs_to :created_by, class_name: "User", optional: true

  enum :genre, { textbook: 0, non_fiction: 1, literature: 2 }
  enum :source, { curated: 0, user_created: 1 }

  validates :title, presence: true
  validates :content, presence: true
  validates :min_grade, presence: true
  validates :max_grade, presence: true
  validate :created_by_required_for_user_created

  scope :for_student, ->(grade_level:) {
    where("min_grade <= ? AND max_grade >= ?", grade_level, grade_level)
  }

  private

  def created_by_required_for_user_created
    if user_created? && created_by_id.blank?
      errors.add(:created_by, "is required for user-created passages")
    end
  end
end
