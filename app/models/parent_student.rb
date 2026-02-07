class ParentStudent < ApplicationRecord
  belongs_to :parent, class_name: "User"
  belongs_to :student, class_name: "User"

  validates :student_id, uniqueness: { scope: :parent_id }
end
