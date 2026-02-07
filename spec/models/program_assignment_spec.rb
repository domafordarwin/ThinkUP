require "rails_helper"

RSpec.describe ProgramAssignment, type: :model do
  describe "associations" do
    it { should belong_to(:program) }
    it { should belong_to(:school) }
  end

  describe "uniqueness" do
    it "prevents duplicate assignment" do
      pa = create(:program_assignment)
      duplicate = build(:program_assignment, program: pa.program, school: pa.school)
      expect(duplicate).not_to be_valid
    end
  end
end
