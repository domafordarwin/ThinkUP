require "rails_helper"

RSpec.describe BloomClassifier do
  describe "#call" do
    let(:mock_client) { double }
    let(:classifier) { BloomClassifier.new("저자는 왜 이런 주장을 했을까요?") }

    before do
      allow(classifier).to receive(:api_key_present?).and_return(true)
      allow(classifier).to receive(:client).and_return(mock_client)
    end

    it "returns a valid bloom level symbol" do
      mock_response = { "choices" => [{ "message" => { "content" => "analyze" } }] }
      allow(mock_client).to receive(:chat).and_return(mock_response)

      result = classifier.call
      expect(StudentQuestion.bloom_levels.keys).to include(result)
    end

    it "defaults to remember for invalid responses" do
      mock_response = { "choices" => [{ "message" => { "content" => "invalid_level" } }] }
      allow(mock_client).to receive(:chat).and_return(mock_response)

      result = classifier.call
      expect(result).to eq("remember")
    end
  end
end
