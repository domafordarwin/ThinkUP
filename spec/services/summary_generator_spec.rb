require "rails_helper"

RSpec.describe SummaryGenerator do
  describe "#call" do
    it "returns a hash with summary, bloom_distribution, competency_scores, highlight_question" do
      session = create(:learning_session)
      create(:student_question, learning_session: session, bloom_level: :analyze)
      create(:student_question, learning_session: session, bloom_level: :evaluate)

      generator = SummaryGenerator.new(session)

      ai_json = {
        "summary" => "학생은 분석과 평가 수준의 질문을 생성했습니다.",
        "competency_scores" => { "comprehension" => 4, "aesthetic" => 3, "communication" => 4 },
        "highlight_question" => "저자는 왜 이런 주장을 했을까요?"
      }.to_json

      mock_response = double(content: [double(text: ai_json)])
      mock_messages = double(create: mock_response)
      mock_client = double(messages: mock_messages)
      allow(generator).to receive(:client).and_return(mock_client)

      result = generator.call
      expect(result).to have_key(:summary)
      expect(result).to have_key(:bloom_distribution)
      expect(result).to have_key(:competency_scores)
      expect(result).to have_key(:highlight_question)
    end
  end
end
