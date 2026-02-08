require "rails_helper"

RSpec.describe Announcement, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end

  describe "associations" do
    it { should belong_to(:user) }
  end

  describe ".published" do
    it "returns only published announcements" do
      published = create(:announcement, published_at: 1.day.ago)
      create(:announcement, published_at: nil)
      create(:announcement, published_at: 1.day.from_now)

      expect(Announcement.published).to contain_exactly(published)
    end
  end
end
