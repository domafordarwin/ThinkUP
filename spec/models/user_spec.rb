require "rails_helper"

RSpec.describe User, type: :model do
  describe "roles" do
    it "defines all six roles" do
      expect(User.roles.keys).to match_array(
        %w[student parent school_admin diagnosis_admin developer system_admin]
      )
    end

    it "defaults to student role" do
      user = User.new
      expect(user.role).to eq("student")
    end
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
  end

  describe "grade_level" do
    it "accepts values 1 through 12" do
      user = build(:user, grade_level: 5)
      expect(user).to be_valid
    end
  end

  describe "thinking_level" do
    it "defaults to 1" do
      user = User.new
      expect(user.thinking_level).to eq(1)
    end
  end
end
