class SessionSummary < ApplicationRecord
  belongs_to :learning_session

  validates :summary, presence: true
end
