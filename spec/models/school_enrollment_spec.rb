require "rails_helper"

RSpec.describe SchoolEnrollment, type: :model do
  describe "associations" do
    it { should belong_to(:school) }
    it { should belong_to(:user) }
  end

  describe "enums" do
    it "defines roles" do
      expect(SchoolEnrollment.role_in_schools.keys).to match_array(
        %w[student_member parent_member admin_member]
      )
    end
  end

  describe "uniqueness" do
    it "prevents duplicate enrollment" do
      enrollment = create(:school_enrollment)
      duplicate = build(:school_enrollment, school: enrollment.school, user: enrollment.user)
      expect(duplicate).not_to be_valid
    end
  end
end
