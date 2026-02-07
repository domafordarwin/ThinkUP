require "rails_helper"

RSpec.describe PassageRecommender do
  describe "#call" do
    it "returns a passage matching student grade level" do
      student = create(:user, grade_level: 5)
      matching = create(:passage, min_grade: 3, max_grade: 6, difficulty: 2)
      create(:passage, min_grade: 7, max_grade: 9)

      result = PassageRecommender.new(student).call
      expect(result).to eq(matching)
    end

    it "excludes passages already completed by the student" do
      student = create(:user, grade_level: 5)
      done_passage = create(:passage, min_grade: 3, max_grade: 6)
      create(:learning_session, user: student, passage: done_passage, status: :completed)
      new_passage = create(:passage, min_grade: 3, max_grade: 6)

      result = PassageRecommender.new(student).call
      expect(result).to eq(new_passage)
    end
  end
end
