class StudentQuestionsController < ApplicationController
  def create
    @session = current_user.learning_sessions.find(params[:learning_session_id])
    @question = @session.student_questions.build(question_params)

    BloomClassifierJob.perform_later(@question.id) if @question.save

    @session.questioning! if @session.base_completed?

    redirect_to learning_session_path(@session)
  end

  private

  def question_params
    params.require(:student_question).permit(:content)
  end
end
