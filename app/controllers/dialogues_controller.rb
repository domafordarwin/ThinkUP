class DialoguesController < ApplicationController
  def create
    @session = current_user.learning_sessions.find(params[:learning_session_id])
    @question = @session.student_questions.find(dialogue_params[:student_question_id])

    if dialogue_params[:content].present?
      @question.ai_dialogues.create!(
        role: :student_reply,
        content: dialogue_params[:content],
        position: @question.ai_dialogues.count
      )
    end

    ai_response = DialogueEngine.new(@question).call
    @question.ai_dialogues.create!(
      role: :ai_prompt,
      content: ai_response,
      position: @question.ai_dialogues.count
    )

    @session.dialogue_active! unless @session.dialogue_active?

    redirect_to learning_session_path(@session, anchor: "dialogue")
  end

  private

  def dialogue_params
    params.require(:dialogue).permit(:student_question_id, :content)
  end
end
