require "rails_helper"

RSpec.describe BloomClassifier do
  describe "#call" do
    let(:mock_messages) { double }
    let(:mock_client) { double(messages: mock_messages) }
    let(:classifier) { BloomClassifier.new("저자는 왜 이런 주장을 했을까요?") }

    before do
      allow(classifier).to receive(:client).and_return(mock_client)
    end

    it "returns a valid bloom level symbol" do
      mock_response = double(content: [double(text: "analyze")])
      allow(mock_messages).to receive(:create).and_return(mock_response)

      result = classifier.call
      expect(StudentQuestion.bloom_levels.keys).to include(result)
    end

    it "defaults to remember for invalid responses" do
      mock_response = double(content: [double(text: "invalid_level")])
      allow(mock_messages).to receive(:create).and_return(mock_response)

      result = classifier.call
      expect(result).to eq("remember")
    end
  end
end
