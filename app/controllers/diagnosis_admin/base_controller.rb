module DiagnosisAdmin
  class BaseController < ApplicationController
    before_action :authorize_diagnosis_admin!

    private

    def authorize_diagnosis_admin!
      unless current_user.diagnosis_admin? || current_user.system_admin?
        redirect_to root_path, alert: "진단 관리자만 접근할 수 있습니다."
      end
    end
  end
end
