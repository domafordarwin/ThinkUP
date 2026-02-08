class ReportGenerator
  def initialize(type:, generated_by:, period_start:, period_end:, user: nil, school: nil)
    @type = type
    @generated_by = generated_by
    @period_start = period_start
    @period_end = period_end
    @user = user
    @school = school
  end

  def call
    data = case @type.to_s
    when "student_report" then generate_student_report
    when "school_report" then generate_school_report
    when "overall_report" then generate_overall_report
    end

    ActivityReport.create!(
      report_type: @type,
      generated_by: @generated_by,
      user: @user,
      school: @school,
      period_start: @period_start,
      period_end: @period_end,
      data: data
    )
  end

  private

  def generate_student_report
    sessions = @user.learning_sessions.completed
      .where(created_at: @period_start.beginning_of_day..@period_end.end_of_day)
    questions = StudentQuestion.where(learning_session: sessions)
    summaries = SessionSummary.where(learning_session: sessions)

    {
      total_sessions: sessions.count,
      bloom_distribution: questions.group(:bloom_level).count,
      competency_averages: avg_competency(summaries),
      questions_count: questions.count
    }
  end

  def generate_school_report
    student_ids = @school.school_enrollments.student_member.pluck(:user_id)
    sessions = LearningSession.completed
      .where(user_id: student_ids, created_at: @period_start.beginning_of_day..@period_end.end_of_day)
    questions = StudentQuestion.where(learning_session: sessions)
    summaries = SessionSummary.where(learning_session: sessions)

    {
      total_students: student_ids.count,
      active_students: sessions.distinct.count(:user_id),
      total_sessions: sessions.count,
      bloom_distribution: questions.group(:bloom_level).count,
      competency_averages: avg_competency(summaries),
      questions_count: questions.count
    }
  end

  def generate_overall_report
    sessions = LearningSession.completed
      .where(created_at: @period_start.beginning_of_day..@period_end.end_of_day)
    questions = StudentQuestion.where(learning_session: sessions)
    summaries = SessionSummary.where(learning_session: sessions)

    {
      total_schools: School.count,
      total_students: User.where(role: :student).count,
      active_students: sessions.distinct.count(:user_id),
      total_sessions: sessions.count,
      bloom_distribution: questions.group(:bloom_level).count,
      competency_averages: avg_competency(summaries),
      questions_count: questions.count
    }
  end

  def avg_competency(summaries)
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
end
