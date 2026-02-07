require "rails_helper"

RSpec.describe DialogueEngine do
  describe "#call" do
    it "returns a follow-up question string" do
      passage = create(:passage, content: "환경 보호에 대한 글입니다.")
      session = create(:learning_session, passage: passage)
      question = create(:student_question, learning_session: session, content: "저자는 왜 환경 보호를 강조하나요?")

      engine = DialogueEngine.new(question)

      mock_response = double(content: [double(text: "왜 그렇게 생각하나요? 근거를 들어 설명해보세요.")])
      mock_messages = double(create: mock_response)
      mock_client = double(messages: mock_messages)
      allow(engine).to receive(:client).and_return(mock_client)

      result = engine.call
      expect(result).to be_a(String)
      expect(result.length).to be > 10
    end
  end
end
