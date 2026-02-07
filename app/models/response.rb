class Response < ApplicationRecord
  belongs_to :learning_session
  belongs_to :base_question

  validates :content, presence: true
end
