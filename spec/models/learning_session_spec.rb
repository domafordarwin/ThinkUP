require "rails_helper"

RSpec.describe LearningSession, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:passage) }
    it { should have_many(:responses).dependent(:destroy) }
    it { should have_many(:student_questions).dependent(:destroy) }
  end

  describe "enums" do
    it "defines statuses" do
      expect(LearningSession.statuses.keys).to match_array(
        %w[in_progress base_completed questioning dialogue_active completed]
      )
    end
  end
end
