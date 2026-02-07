require "rails_helper"

RSpec.describe DashboardStats do
  describe "#call" do
    let(:student) { create(:user, grade_level: 5) }

    before do
      session1 = create(:learning_session, user: student, status: :completed)
      create(:student_question, learning_session: session1, bloom_level: :remember)
      create(:student_question, learning_session: session1, bloom_level: :analyze)
      create(:student_question, learning_session: session1, bloom_level: :analyze)
      create(:session_summary, learning_session: session1,
        competency_scores: { "comprehension" => 4, "aesthetic" => 3, "communication" => 4 })

      session2 = create(:learning_session, user: student, status: :completed)
      create(:student_question, learning_session: session2, bloom_level: :evaluate)
      create(:session_summary, learning_session: session2,
        competency_scores: { "comprehension" => 5, "aesthetic" => 4, "communication" => 3 })
    end

    it "returns bloom distribution" do
      stats = DashboardStats.new(student).call
      expect(stats[:bloom_distribution]).to include("analyze" => 2, "remember" => 1, "evaluate" => 1)
    end

    it "returns average competency scores" do
      stats = DashboardStats.new(student).call
      expect(stats[:competency_averages]["comprehension"]).to eq(4.5)
    end

    it "returns total sessions count" do
      stats = DashboardStats.new(student).call
      expect(stats[:total_sessions]).to eq(2)
    end

    it "returns weekly highlight question" do
      stats = DashboardStats.new(student).call
      expect(stats[:highlight_question]).to be_present
    end
  end
end
