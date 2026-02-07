require "rails_helper"

RSpec.describe Response, type: :model do
  describe "validations" do
    it { should validate_presence_of(:content) }
  end

  describe "associations" do
    it { should belong_to(:learning_session) }
    it { should belong_to(:base_question) }
  end
end
