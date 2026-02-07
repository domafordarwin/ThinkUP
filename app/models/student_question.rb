class StudentQuestion < ApplicationRecord
  belongs_to :learning_session
  has_many :ai_dialogues, dependent: :destroy

  enum :bloom_level, {
    remember: 0,
    understand: 1,
    apply: 2,
    analyze: 3,
    evaluate: 4,
    create_level: 5
  }

  validates :content, presence: true
end
