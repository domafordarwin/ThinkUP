class ResponsesController < ApplicationController
  def create
    @session = current_user.learning_sessions.find(params[:learning_session_id])
    @response = @session.responses.build(response_params)

    if @response.save
      if all_base_questions_answered?
        @session.base_completed!
      end
      redirect_to learning_session_path(@session)
    else
      redirect_to learning_session_path(@session), alert: "답변을 입력해주세요."
    end
  end

  private

  def response_params
    params.require(:response).permit(:base_question_id, :content)
  end

  def all_base_questions_answered?
    answered = @session.responses.pluck(:base_question_id)
    required = @session.passage.base_questions.pluck(:id)
    (required - answered).empty?
  end
end
