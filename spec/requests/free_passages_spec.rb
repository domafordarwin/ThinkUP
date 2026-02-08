require "rails_helper"

RSpec.describe "FreePassages", type: :request do
  let(:student) { create(:user, grade_level: 5) }

  before { sign_in student }

  describe "GET /free_passages/new" do
    it "shows free passage form" do
      get new_free_passage_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /free_passages" do
    it "creates a passage and learning session" do
      expect {
        post free_passages_path, params: {
          passage: { title: "내가 쓴 글", content: "자유롭게 입력한 지문 내용입니다." }
        }
      }.to change(Passage, :count).by(1)
        .and change(LearningSession, :count).by(1)

      passage = Passage.last
      expect(passage.user_created?).to be true
      expect(passage.created_by).to eq(student)
    end

    it "redirects to the created learning session" do
      post free_passages_path, params: {
        passage: { title: "테스트", content: "내용" }
      }
      expect(response).to redirect_to(learning_session_path(LearningSession.last))
    end
  end

  describe "access control" do
    it "only allows students" do
      sign_in create(:user, :developer)
      get new_free_passage_path
      expect(response).to redirect_to(root_path)
    end
  end
end
