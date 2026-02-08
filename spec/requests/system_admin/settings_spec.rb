require "rails_helper"

RSpec.describe "SystemAdmin::Settings", type: :request do
  let(:admin) { create(:user, :system_admin) }

  before { sign_in admin }

  describe "GET /system_admin/settings" do
    it "shows settings page" do
      get system_admin_settings_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /system_admin/settings/:id" do
    it "updates a setting" do
      setting = SystemSetting.create!(key: "max_sessions", value: "5")
      patch system_admin_setting_path(setting), params: { system_setting: { value: "10" } }
      expect(setting.reload.value).to eq("10")
    end
  end
end
