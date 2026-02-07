module SchoolAdmin
  class ProgramsController < ApplicationController
    before_action :authorize_school_admin!
    before_action :set_school

    def index
      @programs = @school.programs.includes(:passages)
    end

    def show
      @program = @school.programs.find(params[:id])
      @passages = @program.passages
      @students = @school.users.where(role: :student)
        .where(grade_level: @program.target_grade_min..@program.target_grade_max)
    end

    private

    def authorize_school_admin!
      unless current_user.school_admin? || current_user.system_admin?
        redirect_to root_path, alert: "학교 담당자만 접근할 수 있습니다."
      end
    end

    def set_school
      @school = current_user.schools.first
      unless @school
        redirect_to root_path, alert: "소속 학교가 없습니다."
      end
    end
  end
end
