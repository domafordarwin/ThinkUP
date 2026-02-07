require "rails_helper"

RSpec.describe ApplicationPolicy do
  let(:student) { build(:user, role: :student) }
  let(:developer) { build(:user, role: :developer) }
  let(:system_admin) { build(:user, role: :system_admin) }

  describe "#admin?" do
    it "returns true for system_admin" do
      policy = described_class.new(system_admin, nil)
      expect(policy.send(:admin?)).to be true
    end

    it "returns false for student" do
      policy = described_class.new(student, nil)
      expect(policy.send(:admin?)).to be false
    end
  end

  describe "#developer?" do
    it "returns true for developer" do
      policy = described_class.new(developer, nil)
      expect(policy.send(:developer?)).to be true
    end
  end
end
