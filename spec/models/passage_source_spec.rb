require "rails_helper"

RSpec.describe "Passage source", type: :model do
  it "has curated as default source" do
    passage = create(:passage)
    expect(passage.curated?).to be true
  end

  it "can be user-created" do
    passage = create(:passage, source: :user_created, created_by: create(:user))
    expect(passage.user_created?).to be true
  end

  it "requires created_by for user_created passages" do
    passage = build(:passage, source: :user_created, created_by_id: nil)
    expect(passage).not_to be_valid
  end
end
