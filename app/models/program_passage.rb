class ProgramPassage < ApplicationRecord
  belongs_to :program
  belongs_to :passage

  validates :passage_id, uniqueness: { scope: :program_id }

  default_scope { order(:position) }
end
