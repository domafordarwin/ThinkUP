class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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
