require "rails_helper"

RSpec.describe "Developer::Passages", type: :request do
  let(:developer) { create(:user, :developer) }
  let(:student) { create(:user) }

  describe "GET /developer/passages" do
    it "allows developer access" do
      sign_in developer
      get developer_passages_path
      expect(response).to have_http_status(:success)
    end

    it "denies student access" do
      sign_in student
      get developer_passages_path
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST /developer/passages" do
    it "creates a passage" do
      sign_in developer
      expect {
        post developer_passages_path, params: {
          passage: {
            title: "테스트 지문",
            content: "본문 내용입니다.",
            genre: "non_fiction",
            difficulty: 3,
            min_grade: 3,
            max_grade: 6,
            subject_tags: "과학"
          }
        }
      }.to change(Passage, :count).by(1)
    end
  end
end
