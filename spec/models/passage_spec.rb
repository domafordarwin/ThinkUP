require "rails_helper"

RSpec.describe Passage, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:min_grade) }
    it { should validate_presence_of(:max_grade) }
  end

  describe "associations" do
    it { should have_many(:base_questions).dependent(:destroy) }
  end

  describe "enums" do
    it "defines genre types" do
      expect(Passage.genres.keys).to match_array(
        %w[textbook non_fiction literature]
      )
    end
  end

  describe ".for_student" do
    it "returns passages matching grade level" do
      matching = create(:passage, min_grade: 3, max_grade: 6)
      create(:passage, min_grade: 7, max_grade: 9)

      results = Passage.for_student(grade_level: 5)
      expect(results).to contain_exactly(matching)
    end
  end
end
