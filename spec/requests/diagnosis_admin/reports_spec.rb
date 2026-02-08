require "rails_helper"

RSpec.describe "DiagnosisAdmin::Reports", type: :request do
  let(:admin) { create(:user, :diagnosis_admin) }

  before { sign_in admin }

  describe "GET /diagnosis_admin/reports" do
    it "shows report list" do
      create(:activity_report, generated_by: admin)
      get diagnosis_admin_reports_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /diagnosis_admin/reports/new" do
    it "shows report creation form" do
      get new_diagnosis_admin_report_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /diagnosis_admin/reports" do
    it "generates an overall report" do
      expect {
        post diagnosis_admin_reports_path, params: {
          report_type: "overall_report",
          period_start: 1.month.ago.to_date.to_s,
          period_end: Date.current.to_s
        }
      }.to change(ActivityReport, :count).by(1)
    end
  end

  describe "GET /diagnosis_admin/reports/:id" do
    it "shows report details" do
      report = create(:activity_report, :overall_report, generated_by: admin)
      get diagnosis_admin_report_path(report)
      expect(response).to have_http_status(:success)
    end
  end
end
