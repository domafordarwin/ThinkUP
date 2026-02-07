class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :learning_sessions, dependent: :destroy
  has_many :school_enrollments, dependent: :destroy
  has_many :schools, through: :school_enrollments

  enum :role, {
    student: 0,
    parent: 1,
    school_admin: 2,
    diagnosis_admin: 3,
    developer: 4,
    system_admin: 5
  }

  validates :name, presence: true
end
