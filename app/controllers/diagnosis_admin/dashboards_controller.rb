module DiagnosisAdmin
  class DashboardsController < BaseController
    def show
      @total_schools = School.count
      @total_students = User.where(role: :student).count
      @total_parents = User.where(role: :parent).count
      @active_programs = Program.active.count
      @monthly_sessions = LearningSession.completed
        .where(created_at: 1.month.ago..).count
      @total_questions = StudentQuestion.count

      @schools = School.includes(:school_enrollments, :programs).all
    end
  end
end
