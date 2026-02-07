require "rails_helper"

RSpec.describe StudentQuestion, type: :model do
  describe "validations" do
    it { should validate_presence_of(:content) }
  end

  describe "associations" do
    it { should belong_to(:learning_session) }
    it { should have_many(:ai_dialogues).dependent(:destroy) }
  end

  describe "enums" do
    it "defines all six bloom levels" do
      expect(StudentQuestion.bloom_levels.keys).to match_array(
        %w[remember understand apply analyze evaluate create_level]
      )
    end
  end
end
