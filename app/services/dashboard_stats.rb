class DashboardStats
  def initialize(user)
    @user = user
  end

  def call
    sessions = @user.learning_sessions.completed
    questions = StudentQuestion.where(learning_session: sessions)
    summaries = SessionSummary.where(learning_session: sessions)

    {
      total_sessions: sessions.count,
      bloom_distribution: bloom_distribution(questions),
      competency_averages: competency_averages(summaries),
      highlight_question: highlight_question(summaries),
      recent_sessions: sessions.order(created_at: :desc).limit(5).includes(:passage, :session_summary)
    }
  end

  private

  def bloom_distribution(questions)
    questions.group(:bloom_level).count
  end

  def competency_averages(summaries)
    return {} if summaries.empty?

    totals = Hash.new(0.0)
    count = 0

    summaries.each do |s|
      next if s.competency_scores.blank?
      s.competency_scores.each { |k, v| totals[k] += v.to_f }
      count += 1
    end

    return {} if count == 0
    totals.transform_values { |v| (v / count).round(1) }
  end

  def highlight_question(summaries)
    recent = summaries.where(created_at: 1.week.ago..).order(created_at: :desc).first
    recent&.highlight_question
  end
end
