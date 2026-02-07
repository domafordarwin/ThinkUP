class School < ApplicationRecord
  has_many :school_enrollments, dependent: :destroy
  has_many :users, through: :school_enrollments

  validates :name, presence: true
end
