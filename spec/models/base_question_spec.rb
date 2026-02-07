require "rails_helper"

RSpec.describe BaseQuestion, type: :model do
  describe "validations" do
    it { should validate_presence_of(:content) }
  end

  describe "associations" do
    it { should belong_to(:passage) }
  end

  describe "enums" do
    it "defines bloom levels" do
      expect(BaseQuestion.bloom_levels.keys).to match_array(
        %w[remember understand apply]
      )
    end
  end
end
