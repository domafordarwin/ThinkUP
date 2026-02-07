class School < ApplicationRecord
  has_many :school_enrollments, dependent: :destroy
  has_many :users, through: :school_enrollments
  has_many :program_assignments, dependent: :destroy
  has_many :programs, through: :program_assignments

  validates :name, presence: true
end
