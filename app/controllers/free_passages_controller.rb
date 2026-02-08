class FreePassagesController < ApplicationController
  before_action :authorize_student!

  def new
    @passage = Passage.new
  end

  def create
    @passage = Passage.new(passage_params)
    @passage.source = :user_created
    @passage.created_by = current_user
    @passage.genre = :non_fiction
    @passage.difficulty = 1
    @passage.min_grade = current_user.grade_level
    @passage.max_grade = current_user.grade_level

    if @passage.save
      session = current_user.learning_sessions.create!(
        passage: @passage,
        status: :in_progress,
        current_bloom_stage: current_user.thinking_level
      )
      redirect_to learning_session_path(session)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def authorize_student!
    unless current_user.student?
      redirect_to root_path, alert: "학생만 이용할 수 있습니다."
    end
  end

  def passage_params
    params.require(:passage).permit(:title, :content)
  end
end
