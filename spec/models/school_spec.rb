require "rails_helper"

RSpec.describe School, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "associations" do
    it { should have_many(:school_enrollments).dependent(:destroy) }
    it { should have_many(:users).through(:school_enrollments) }
  end
end
