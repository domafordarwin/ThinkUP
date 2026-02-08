require "rails_helper"

RSpec.describe ActivityReport, type: :model do
  describe "validations" do
    it { should validate_presence_of(:report_type) }
    it { should validate_presence_of(:period_start) }
    it { should validate_presence_of(:period_end) }
  end

  describe "associations" do
    it { should belong_to(:user).optional }
    it { should belong_to(:school).optional }
    it { should belong_to(:generated_by).class_name("User") }
  end

  describe "enums" do
    it "defines report types" do
      expect(ActivityReport.report_types.keys).to match_array(
        %w[student_report school_report overall_report]
      )
    end
  end
end
