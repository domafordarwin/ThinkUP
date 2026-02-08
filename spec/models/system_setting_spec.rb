require "rails_helper"

RSpec.describe SystemSetting, type: :model do
  describe "validations" do
    subject { build(:system_setting) }

    it { should validate_presence_of(:key) }
    it { should validate_uniqueness_of(:key) }
    it { should validate_presence_of(:value) }
  end

  describe ".get" do
    it "returns value for existing key" do
      SystemSetting.create!(key: "max_sessions_per_day", value: "5")
      expect(SystemSetting.get("max_sessions_per_day")).to eq("5")
    end

    it "returns default for missing key" do
      expect(SystemSetting.get("missing", default: "10")).to eq("10")
    end
  end

  describe ".set" do
    it "creates new setting" do
      SystemSetting.set("new_key", "new_value")
      expect(SystemSetting.get("new_key")).to eq("new_value")
    end

    it "updates existing setting" do
      SystemSetting.create!(key: "existing", value: "old")
      SystemSetting.set("existing", "new")
      expect(SystemSetting.get("existing")).to eq("new")
    end
  end
end
