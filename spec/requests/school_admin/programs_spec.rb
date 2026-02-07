require "rails_helper"

RSpec.describe "SchoolAdmin::Programs", type: :request do
  let(:school) { create(:school) }
  let(:school_admin) { create(:user, :school_admin) }
  let(:program) { create(:program) }

  before do
    create(:school_enrollment, school: school, user: school_admin, role_in_school: :admin_member)
    create(:program_assignment, program: program, school: school)
    sign_in school_admin
  end

  describe "GET /school_admin/programs" do
    it "shows assigned programs" do
      get school_admin_programs_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /school_admin/programs/:id" do
    it "shows program details" do
      get school_admin_program_path(program)
      expect(response).to have_http_status(:success)
    end
  end
end
