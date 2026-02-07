require "rails_helper"

RSpec.describe "Dashboards", type: :request do
  let(:student) { create(:user) }

  describe "GET /dashboard" do
    it "shows the dashboard for logged-in user" do
      sign_in student
      get dashboard_path
      expect(response).to have_http_status(:success)
    end

    it "redirects unauthenticated users" do
      get dashboard_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
