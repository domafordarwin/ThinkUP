class Announcement < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true

  scope :published, -> { where("published_at IS NOT NULL AND published_at <= ?", Time.current) }
  scope :recent, -> { published.order(published_at: :desc).limit(5) }
end
