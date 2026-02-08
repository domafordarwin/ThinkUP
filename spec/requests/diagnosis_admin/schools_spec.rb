require "rails_helper"

RSpec.describe "DiagnosisAdmin::Schools", type: :request do
  let(:admin) { create(:user, :diagnosis_admin) }

  before { sign_in admin }

  describe "GET /diagnosis_admin/schools" do
    it "shows school list" do
      create(:school)
      get diagnosis_admin_schools_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /diagnosis_admin/schools" do
    it "creates a new school" do
      expect {
        post diagnosis_admin_schools_path, params: {
          school: { name: "테스트초등학교", region: "부산" }
        }
      }.to change(School, :count).by(1)
    end
  end

  describe "GET /diagnosis_admin/schools/:id" do
    it "shows school details" do
      school = create(:school)
      get diagnosis_admin_school_path(school)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /diagnosis_admin/schools/:id" do
    it "updates school" do
      school = create(:school)
      patch diagnosis_admin_school_path(school), params: { school: { name: "수정된학교" } }
      expect(school.reload.name).to eq("수정된학교")
    end
  end

  describe "access control" do
    it "denies student access" do
      sign_in create(:user)
      get diagnosis_admin_schools_path
      expect(response).to redirect_to(root_path)
    end
  end
end
