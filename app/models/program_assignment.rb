class ProgramAssignment < ApplicationRecord
  belongs_to :program
  belongs_to :school

  validates :school_id, uniqueness: { scope: :program_id }
end
