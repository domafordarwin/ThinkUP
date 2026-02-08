module DiagnosisAdmin
  class SchoolsController < BaseController
    before_action :set_school, only: [:show, :edit, :update, :destroy]

    def index
      @schools = School.includes(:school_enrollments).all
    end

    def new
      @school = School.new
    end

    def create
      @school = School.new(school_params)

      if @school.save
        if params[:admin_user_id].present?
          admin_user = User.find(params[:admin_user_id])
          @school.school_enrollments.create!(user: admin_user, role_in_school: :admin_member)
        end
        redirect_to diagnosis_admin_school_path(@school), notice: "#{@school.name}이(가) 등록되었습니다."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show
      @enrollments = @school.school_enrollments.includes(:user)
      @programs = @school.programs
    end

    def edit
    end

    def update
      if @school.update(school_params)
        redirect_to diagnosis_admin_school_path(@school), notice: "학교 정보가 수정되었습니다."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @school.destroy
      redirect_to diagnosis_admin_schools_path, notice: "#{@school.name}이(가) 삭제되었습니다."
    end

    private

    def set_school
      @school = School.find(params[:id])
    end

    def school_params
      params.require(:school).permit(:name, :region)
    end
  end
end
