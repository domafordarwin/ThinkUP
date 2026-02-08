module DiagnosisAdmin
  class ReportsController < BaseController
    def index
      @reports = ActivityReport.order(created_at: :desc).includes(:user, :school, :generated_by)
    end

    def new
      @schools = School.all
      @students = User.where(role: :student)
    end

    def create
      report = ReportGenerator.new(
        type: params[:report_type],
        generated_by: current_user,
        user: params[:user_id].present? ? User.find(params[:user_id]) : nil,
        school: params[:school_id].present? ? School.find(params[:school_id]) : nil,
        period_start: Date.parse(params[:period_start]),
        period_end: Date.parse(params[:period_end])
      ).call

      redirect_to diagnosis_admin_report_path(report), notice: "보고서가 생성되었습니다."
    end

    def show
      @report = ActivityReport.find(params[:id])
    end
  end
end
