class BloomClassifier
  PROMPT = <<~PROMPT
    You are an educational assessment expert. Classify the following student-generated question
    into one of Bloom's Taxonomy levels. Respond with ONLY the level name in lowercase.

    Levels: remember, understand, apply, analyze, evaluate, create_level

    Guidelines:
    - remember: 사실 확인 (누가, 무엇, 언제, 어디서)
    - understand: 의미 파악, 자기 말로 설명
    - apply: 다른 상황에 적용, 예시 들기
    - analyze: 구조 분석, 비교, 원인 탐구 (왜?)
    - evaluate: 판단, 비판, 가치 평가, 근거 제시
    - create_level: 대안 제시, 새로운 관점, 재구성 (만약~라면?)

    Student question: "%{question}"

    Bloom level:
  PROMPT

  def initialize(question_text)
    @question_text = question_text
  end

  def call
    return mock_classify unless api_key_present?

    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [{ role: "user", content: PROMPT % { question: @question_text } }],
        max_tokens: 10
      }
    )

    level = response.dig("choices", 0, "message", "content").strip.downcase
    valid_levels = StudentQuestion.bloom_levels.keys
    valid_levels.include?(level) ? level : "remember"
  rescue StandardError => e
    Rails.logger.error("BloomClassifier API error: #{e.message}")
    mock_classify
  end

  private

  def api_key_present?
    ENV["OPENAI_API_KEY"].present?
  end

  def mock_classify
    %w[analyze evaluate apply understand].sample
  end

  def client
    @client ||= OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
  end
end
