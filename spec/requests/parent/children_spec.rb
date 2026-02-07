require "rails_helper"

RSpec.describe "Parent::Children", type: :request do
  let(:parent_user) { create(:user, :parent) }
  let(:child) { create(:user, grade_level: 5) }

  before do
    create(:parent_student, parent: parent_user, student: child)
    sign_in parent_user
  end

  describe "GET /parent/children" do
    it "shows children list" do
      get parent_children_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /parent/children/:id" do
    it "shows child learning status" do
      get parent_child_path(child)
      expect(response).to have_http_status(:success)
    end

    it "denies access to unrelated child" do
      other_child = create(:user)
      get parent_child_path(other_child)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "access control" do
    it "denies student access" do
      sign_in child
      get parent_children_path
      expect(response).to redirect_to(root_path)
    end
  end
end
