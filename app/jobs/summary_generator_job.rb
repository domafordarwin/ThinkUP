class SummaryGeneratorJob < ApplicationJob
  queue_as :default

  def perform(learning_session_id)
    session = LearningSession.find(learning_session_id)
    result = SummaryGenerator.new(session).call

    session.create_session_summary!(
      summary: result[:summary],
      bloom_distribution: result[:bloom_distribution],
      competency_scores: result[:competency_scores],
      highlight_question: result[:highlight_question]
    )
  end
end
