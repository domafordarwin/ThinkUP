require "rails_helper"

RSpec.describe Program, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:target_grade_min) }
    it { should validate_presence_of(:target_grade_max) }
    it { should validate_presence_of(:starts_on) }
    it { should validate_presence_of(:ends_on) }
  end

  describe "associations" do
    it { should have_many(:program_assignments).dependent(:destroy) }
    it { should have_many(:schools).through(:program_assignments) }
    it { should have_many(:program_passages).dependent(:destroy) }
    it { should have_many(:passages).through(:program_passages) }
  end

  describe ".active" do
    it "returns programs within date range" do
      active = create(:program, starts_on: 1.day.ago, ends_on: 1.month.from_now)
      create(:program, starts_on: 2.months.ago, ends_on: 1.month.ago)

      expect(Program.active).to contain_exactly(active)
    end
  end
end
