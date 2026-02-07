require "rails_helper"

RSpec.describe AiDialogue, type: :model do
  describe "validations" do
    it { should validate_presence_of(:content) }
  end

  describe "associations" do
    it { should belong_to(:student_question) }
  end

  describe "enums" do
    it "defines roles" do
      expect(AiDialogue.roles.keys).to match_array(%w[ai_prompt student_reply])
    end
  end
end
