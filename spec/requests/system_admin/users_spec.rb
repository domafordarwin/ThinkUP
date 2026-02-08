require "rails_helper"

RSpec.describe "SystemAdmin::Users", type: :request do
  let(:admin) { create(:user, :system_admin) }

  before { sign_in admin }

  describe "GET /system_admin/users" do
    it "lists all users" do
      create_list(:user, 3)
      get system_admin_users_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /system_admin/users/new" do
    it "shows new user form" do
      get new_system_admin_user_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /system_admin/users" do
    it "creates a user with specified role" do
      expect {
        post system_admin_users_path, params: {
          user: { name: "새 사용자", email: "new@thinkup.kr", password: "password123", role: "developer" }
        }
      }.to change(User, :count).by(1)
      expect(User.last.developer?).to be true
    end
  end

  describe "GET /system_admin/users/:id" do
    it "shows user details" do
      user = create(:user)
      get system_admin_user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /system_admin/users/:id/edit" do
    it "shows edit form" do
      user = create(:user)
      get edit_system_admin_user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /system_admin/users/:id" do
    it "updates user role" do
      user = create(:user)
      patch system_admin_user_path(user), params: { user: { role: "school_admin" } }
      expect(user.reload.school_admin?).to be true
    end
  end

  describe "access control" do
    it "redirects non-system-admin users" do
      sign_in create(:user, :diagnosis_admin)
      get system_admin_users_path
      expect(response).to redirect_to(root_path)
    end
  end
end
