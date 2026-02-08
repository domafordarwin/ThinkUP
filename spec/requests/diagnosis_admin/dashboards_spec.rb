require "rails_helper"

RSpec.describe "DiagnosisAdmin::Dashboards", type: :request do
  let(:admin) { create(:user, :diagnosis_admin) }

  before { sign_in admin }

  describe "GET /diagnosis_admin/dashboard" do
    it "shows monitoring dashboard" do
      create(:school)
      get diagnosis_admin_dashboard_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "access control" do
    it "denies student access" do
      sign_in create(:user)
      get diagnosis_admin_dashboard_path
      expect(response).to redirect_to(root_path)
    end
  end
end
