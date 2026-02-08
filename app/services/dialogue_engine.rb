class DialogueEngine
  SYSTEM_PROMPT = <<~PROMPT
    당신은 하브루타(Havruta) 방식으로 학생의 사고를 깊게 만드는 교육 대화 파트너입니다.

    규칙:
    1. 학생이 만든 발문을 기반으로 사고를 확장하는 후속 질문을 던지세요.
    2. "왜 그렇게 생각하나요?", "만약 ~라면 어떨까요?", "근거는 무엇인가요?" 같은 하브루타 형식을 사용하세요.
    3. 학생의 사고 수준보다 한 단계 높은 질문을 던지세요.
    4. 한 번에 하나의 질문만 던지세요.
    5. 답을 직접 알려주지 마세요. 학생이 스스로 생각하게 유도하세요.
    6. 학생의 학년 수준에 맞는 쉬운 언어를 사용하세요.
    7. 질문은 2~3문장 이내로 짧게 유지하세요.
  PROMPT

  def initialize(student_question)
    @student_question = student_question
    @session = student_question.learning_session
    @passage = @session.passage
  end

  def call
    return mock_response unless api_key_present?

    messages = build_messages
    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [{ role: "system", content: SYSTEM_PROMPT }] + messages,
        max_tokens: 300
      }
    )
    response.dig("choices", 0, "message", "content").strip
  rescue StandardError => e
    Rails.logger.error("DialogueEngine API error: #{e.message}")
    mock_response
  end

  private

  def build_messages
    messages = [
      { role: "user", content: "지문: #{@passage.content}" },
      { role: "assistant", content: "네, 지문을 읽었습니다." },
      { role: "user", content: "학생이 만든 발문: #{@student_question.content}" }
    ]

    @student_question.ai_dialogues.each do |dialogue|
      role = dialogue.ai_prompt? ? "assistant" : "user"
      messages << { role: role, content: dialogue.content }
    end

    messages
  end

  def api_key_present?
    ENV["OPENAI_API_KEY"].present?
  end

  def mock_response
    "좋은 생각이에요! 그렇다면 왜 그렇게 생각하나요? 다른 관점에서도 한번 생각해볼까요?"
  end

  def client
    @client ||= OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
  end
end
