class Program < ApplicationRecord
  has_many :program_assignments, dependent: :destroy
  has_many :schools, through: :program_assignments
  has_many :program_passages, dependent: :destroy
  has_many :passages, through: :program_passages

  validates :name, presence: true
  validates :target_grade_min, presence: true
  validates :target_grade_max, presence: true
  validates :starts_on, presence: true
  validates :ends_on, presence: true

  scope :active, -> { where("starts_on <= ? AND ends_on >= ?", Date.current, Date.current) }
end
