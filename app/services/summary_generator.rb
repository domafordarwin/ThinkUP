class SummaryGenerator
  PROMPT = <<~PROMPT
    다음은 학생의 학습 세션 데이터입니다. 세션 요약을 JSON으로 작성하세요.

    지문: %{passage}
    학생이 만든 발문들: %{questions}
    대화 내역: %{dialogues}

    다음 JSON 형식으로만 응답하세요:
    {
      "summary": "학생의 사고 과정에 대한 2~3문장 요약 (한국어)",
      "competency_scores": {
        "comprehension": 1~5 점수,
        "aesthetic": 1~5 점수,
        "communication": 1~5 점수
      },
      "highlight_question": "이 세션에서 가장 높은 수준의 발문 원문"
    }
  PROMPT

  def initialize(learning_session)
    @session = learning_session
  end

  def call
    questions = @session.student_questions
    bloom_dist = questions.group(:bloom_level).count

    ai_result = generate_ai_summary(questions)

    {
      summary: ai_result["summary"],
      bloom_distribution: bloom_dist,
      competency_scores: ai_result["competency_scores"],
      highlight_question: ai_result["highlight_question"]
    }
  end

  private

  def generate_ai_summary(questions)
    return mock_summary(questions) unless api_key_present?

    dialogues_text = questions.flat_map { |q|
      q.ai_dialogues.map { |d| "#{d.role}: #{d.content}" }
    }.join("\n")

    prompt = PROMPT % {
      passage: @session.passage.content.truncate(1000),
      questions: questions.map(&:content).join("\n"),
      dialogues: dialogues_text.truncate(2000)
    }

    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [{ role: "user", content: prompt }],
        max_tokens: 500
      }
    )

    JSON.parse(response.dig("choices", 0, "message", "content"))
  rescue StandardError => e
    Rails.logger.error("SummaryGenerator API error: #{e.message}")
    mock_summary(questions)
  end

  def api_key_present?
    ENV["OPENAI_API_KEY"].present?
  end

  def mock_summary(questions)
    highlight = questions.order(bloom_level: :desc).first&.content || ""
    {
      "summary" => "학생은 지문을 읽고 #{questions.count}개의 발문을 생성하며 적극적으로 사고를 확장했습니다. 다양한 관점에서 질문을 던지는 모습이 인상적입니다.",
      "competency_scores" => { "comprehension" => 3, "aesthetic" => 3, "communication" => 3 },
      "highlight_question" => highlight
    }
  end

  def client
    @client ||= OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
  end
end
