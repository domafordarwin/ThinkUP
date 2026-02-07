require "rails_helper"

RSpec.describe "SchoolAdmin::Members", type: :request do
  let(:school) { create(:school) }
  let(:school_admin) { create(:user, :school_admin) }
  let(:student) { create(:user) }

  before do
    create(:school_enrollment, school: school, user: school_admin, role_in_school: :admin_member)
    sign_in school_admin
  end

  describe "GET /school_admin/members" do
    it "shows school members" do
      create(:school_enrollment, school: school, user: student, role_in_school: :student_member)
      get school_admin_members_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /school_admin/members" do
    it "creates a new student account" do
      expect {
        post school_admin_members_path, params: {
          user: { name: "새학생", email: "new@test.kr", role: "student", grade_level: 5 }
        }
      }.to change(User, :count).by(1)
    end
  end

  describe "access control" do
    it "denies student access" do
      sign_in student
      get school_admin_members_path
      expect(response).to redirect_to(root_path)
    end
  end
end
