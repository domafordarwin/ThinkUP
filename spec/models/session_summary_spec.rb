require "rails_helper"

RSpec.describe SessionSummary, type: :model do
  describe "validations" do
    it { should validate_presence_of(:summary) }
  end

  describe "associations" do
    it { should belong_to(:learning_session) }
  end

  describe "bloom_distribution" do
    it "stores bloom level counts as JSON" do
      summary = create(:session_summary, bloom_distribution: {
        "remember" => 1, "analyze" => 2, "evaluate" => 1
      })
      expect(summary.bloom_distribution["analyze"]).to eq(2)
    end
  end
end
