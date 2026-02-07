class PassageRecommender
  def initialize(user)
    @user = user
  end

  def call
    completed_ids = @user.learning_sessions.completed.pluck(:passage_id)

    Passage
      .for_student(grade_level: @user.grade_level)
      .where.not(id: completed_ids)
      .order(:difficulty)
      .first
  end
end
