module DiagnosisAdmin
  class ProgramsController < BaseController
    before_action :set_program, only: [:show, :edit, :update, :destroy]

    def index
      @programs = Program.includes(:schools, :passages).all
    end

    def new
      @program = Program.new
      @schools = School.all
      @passages = Passage.all
    end

    def create
      @program = Program.new(program_params)

      if @program.save
        assign_schools
        assign_passages
        redirect_to diagnosis_admin_program_path(@program), notice: "#{@program.name} 프로그램이 생성되었습니다."
      else
        @schools = School.all
        @passages = Passage.all
        render :new, status: :unprocessable_entity
      end
    end

    def show
      @assignments = @program.program_assignments.includes(:school)
      @passages = @program.passages
    end

    def edit
      @schools = School.all
      @passages = Passage.all
    end

    def update
      if @program.update(program_params)
        assign_schools
        assign_passages
        redirect_to diagnosis_admin_program_path(@program), notice: "프로그램이 수정되었습니다."
      else
        @schools = School.all
        @passages = Passage.all
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @program.destroy
      redirect_to diagnosis_admin_programs_path, notice: "프로그램이 삭제되었습니다."
    end

    private

    def set_program
      @program = Program.find(params[:id])
    end

    def program_params
      params.require(:program).permit(:name, :description, :target_grade_min, :target_grade_max, :starts_on, :ends_on)
    end

    def assign_schools
      return unless params[:school_ids].present?
      @program.program_assignments.destroy_all
      params[:school_ids].reject(&:blank?).each do |school_id|
        @program.program_assignments.create!(school_id: school_id)
      end
    end

    def assign_passages
      return unless params[:passage_ids].present?
      @program.program_passages.destroy_all
      params[:passage_ids].reject(&:blank?).each_with_index do |passage_id, i|
        @program.program_passages.create!(passage_id: passage_id, position: i)
      end
    end
  end
end
