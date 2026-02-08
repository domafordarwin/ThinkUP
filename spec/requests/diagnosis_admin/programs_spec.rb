require "rails_helper"

RSpec.describe "DiagnosisAdmin::Programs", type: :request do
  let(:admin) { create(:user, :diagnosis_admin) }

  before { sign_in admin }

  describe "GET /diagnosis_admin/programs" do
    it "shows program list" do
      create(:program)
      get diagnosis_admin_programs_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /diagnosis_admin/programs" do
    it "creates a new program with school assignment" do
      school = create(:school)

      expect {
        post diagnosis_admin_programs_path, params: {
          program: {
            name: "테스트 프로그램",
            target_grade_min: 3, target_grade_max: 6,
            starts_on: Date.current, ends_on: 3.months.from_now
          },
          school_ids: [school.id]
        }
      }.to change(Program, :count).by(1)

      expect(Program.last.schools).to include(school)
    end
  end

  describe "GET /diagnosis_admin/programs/:id" do
    it "shows program details" do
      program = create(:program)
      get diagnosis_admin_program_path(program)
      expect(response).to have_http_status(:success)
    end
  end

  describe "access control" do
    it "denies student access" do
      sign_in create(:user)
      get diagnosis_admin_programs_path
      expect(response).to redirect_to(root_path)
    end
  end
end
