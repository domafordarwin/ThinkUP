class BaseQuestion < ApplicationRecord
  belongs_to :passage

  enum :bloom_level, { remember: 0, understand: 1, apply: 2 }

  validates :content, presence: true

  default_scope { order(:position) }
end
