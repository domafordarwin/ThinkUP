require "rails_helper"

RSpec.describe "LearningSessions", type: :request do
  let(:student) { create(:user, grade_level: 5) }
  let!(:passage) { create(:passage, min_grade: 3, max_grade: 6) }

  before { sign_in student }

  describe "POST /learning_sessions" do
    it "creates a new session and redirects" do
      expect {
        post learning_sessions_path
      }.to change(LearningSession, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET /learning_sessions/:id" do
    it "shows the session" do
      session = create(:learning_session, user: student, passage: passage)
      get learning_session_path(session)
      expect(response).to have_http_status(:success)
    end
  end
end
