class LearningSessionsController < ApplicationController
  def create
    passage = PassageRecommender.new(current_user).call

    if passage.nil?
      redirect_to root_path, alert: "현재 학습할 수 있는 지문이 없습니다."
      return
    end

    @session = current_user.learning_sessions.create!(
      passage: passage,
      status: :in_progress,
      current_bloom_stage: current_user.thinking_level
    )

    redirect_to learning_session_path(@session)
  end

  def show
    @session = current_user.learning_sessions.find(params[:id])
    @passage = @session.passage
    @base_questions = @passage.base_questions
    @responses = @session.responses
    @student_questions = @session.student_questions
  end

  def complete
    @session = current_user.learning_sessions.find(params[:id])
    @session.completed!

    SummaryGeneratorJob.perform_later(@session.id)

    redirect_to learning_session_path(@session), notice: "학습 세션이 완료되었습니다."
  end
end
