class SchoolEnrollment < ApplicationRecord
  belongs_to :school
  belongs_to :user

  enum :role_in_school, { student_member: 0, parent_member: 1, admin_member: 2 }

  validates :user_id, uniqueness: { scope: :school_id }
end
