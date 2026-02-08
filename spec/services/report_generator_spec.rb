require "rails_helper"

RSpec.describe ReportGenerator do
  let(:admin) { create(:user, :diagnosis_admin) }
  let(:student) { create(:user, grade_level: 5) }
  let(:school) { create(:school) }

  before do
    create(:school_enrollment, school: school, user: student, role_in_school: :student_member)
    session = create(:learning_session, user: student, status: :completed)
    create(:student_question, learning_session: session, bloom_level: :analyze)
    create(:session_summary, learning_session: session,
      competency_scores: { "comprehension" => 4, "aesthetic" => 3, "communication" => 5 })
  end

  describe "student report" do
    it "generates a student report" do
      report = ReportGenerator.new(
        type: :student_report,
        generated_by: admin,
        user: student,
        period_start: 1.month.ago.to_date,
        period_end: Date.current
      ).call

      expect(report).to be_persisted
      expect(report.student_report?).to be true
      expect(report.data["total_sessions"]).to eq(1)
      expect(report.data["questions_count"]).to eq(1)
    end
  end

  describe "school report" do
    it "generates a school report" do
      report = ReportGenerator.new(
        type: :school_report,
        generated_by: admin,
        school: school,
        period_start: 1.month.ago.to_date,
        period_end: Date.current
      ).call

      expect(report).to be_persisted
      expect(report.school_report?).to be true
      expect(report.data["total_students"]).to eq(1)
      expect(report.data["total_sessions"]).to eq(1)
    end
  end

  describe "overall report" do
    it "generates an overall report" do
      report = ReportGenerator.new(
        type: :overall_report,
        generated_by: admin,
        period_start: 1.month.ago.to_date,
        period_end: Date.current
      ).call

      expect(report).to be_persisted
      expect(report.overall_report?).to be true
      expect(report.data["total_schools"]).to be >= 1
    end
  end
end
