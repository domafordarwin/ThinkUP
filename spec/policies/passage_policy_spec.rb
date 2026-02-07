require "rails_helper"

RSpec.describe PassagePolicy do
  let(:student) { build(:user, role: :student) }
  let(:developer) { build(:user, role: :developer) }

  describe "#create?" do
    it "allows developer" do
      expect(PassagePolicy.new(developer, Passage.new).create?).to be true
    end

    it "denies student" do
      expect(PassagePolicy.new(student, Passage.new).create?).to be false
    end
  end
end
