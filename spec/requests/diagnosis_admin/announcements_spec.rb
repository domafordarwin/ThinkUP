require "rails_helper"

RSpec.describe "DiagnosisAdmin::Announcements", type: :request do
  let(:admin) { create(:user, :diagnosis_admin) }

  before { sign_in admin }

  describe "GET /diagnosis_admin/announcements" do
    it "shows announcement list" do
      create(:announcement)
      get diagnosis_admin_announcements_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /diagnosis_admin/announcements" do
    it "creates a new announcement" do
      expect {
        post diagnosis_admin_announcements_path, params: {
          announcement: { title: "테스트 공지", content: "내용입니다.", published_at: Time.current }
        }
      }.to change(Announcement, :count).by(1)
    end
  end

  describe "GET /diagnosis_admin/announcements/:id" do
    it "shows announcement" do
      announcement = create(:announcement)
      get diagnosis_admin_announcement_path(announcement)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /diagnosis_admin/announcements/:id" do
    it "updates announcement" do
      announcement = create(:announcement)
      patch diagnosis_admin_announcement_path(announcement), params: {
        announcement: { title: "수정된 제목" }
      }
      expect(announcement.reload.title).to eq("수정된 제목")
    end
  end
end
