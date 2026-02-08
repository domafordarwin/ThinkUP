module SystemAdmin
  class BaseController < ApplicationController
    before_action :authorize_system_admin!

    private

    def authorize_system_admin!
      unless current_user.system_admin?
        redirect_to root_path, alert: "시스템 관리자만 접근할 수 있습니다."
      end
    end
  end
end
