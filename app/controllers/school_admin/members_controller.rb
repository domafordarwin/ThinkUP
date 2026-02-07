module SchoolAdmin
  class MembersController < ApplicationController
    before_action :authorize_school_admin!
    before_action :set_school

    def index
      @students = @school.users.where(role: :student)
      @parents = @school.users.where(role: :parent)
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(member_params)
      @user.password = SecureRandom.hex(8)

      if @user.save
        role_in_school = @user.student? ? :student_member : :parent_member
        @school.school_enrollments.create!(user: @user, role_in_school: role_in_school)

        if @user.parent? && params[:student_id].present?
          student = User.find(params[:student_id])
          ParentStudent.create!(parent: @user, student: student)
        end

        redirect_to school_admin_members_path, notice: "#{@user.name} 계정이 생성되었습니다."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show
      @member = User.find(params[:id])
      @sessions = @member.learning_sessions.includes(:passage, :session_summary).order(created_at: :desc) if @member.student?
    end

    def destroy
      @member = User.find(params[:id])
      enrollment = @school.school_enrollments.find_by(user: @member)
      enrollment&.destroy
      redirect_to school_admin_members_path, notice: "#{@member.name}의 소속이 해제되었습니다."
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

    def member_params
      params.require(:user).permit(:name, :email, :role, :grade_level)
    end
  end
end
