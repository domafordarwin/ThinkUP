require "rails_helper"

RSpec.describe ProgramPassage, type: :model do
  describe "associations" do
    it { should belong_to(:program) }
    it { should belong_to(:passage) }
  end

  describe "uniqueness" do
    it "prevents duplicate program-passage" do
      pp = create(:program_passage)
      duplicate = build(:program_passage, program: pp.program, passage: pp.passage)
      expect(duplicate).not_to be_valid
    end
  end
end
