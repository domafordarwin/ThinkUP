class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :learning_sessions, dependent: :destroy
  has_many :school_enrollments, dependent: :destroy
  has_many :schools, through: :school_enrollments

  has_many :parent_student_as_parent, class_name: "ParentStudent", foreign_key: :parent_id, dependent: :destroy
  has_many :children, through: :parent_student_as_parent, source: :student

  has_many :parent_student_as_student, class_name: "ParentStudent", foreign_key: :student_id, dependent: :destroy
  has_many :parents_of_student, through: :parent_student_as_student, source: :parent

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
