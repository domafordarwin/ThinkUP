require "rails_helper"

RSpec.describe ParentStudent, type: :model do
  describe "associations" do
    it { should belong_to(:parent).class_name("User") }
    it { should belong_to(:student).class_name("User") }
  end

  describe "uniqueness" do
    it "prevents duplicate parent-student relationship" do
      ps = create(:parent_student)
      duplicate = build(:parent_student, parent: ps.parent, student: ps.student)
      expect(duplicate).not_to be_valid
    end
  end
end
