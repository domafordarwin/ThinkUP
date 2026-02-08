module SystemAdmin
  class SettingsController < BaseController
    def index
      @settings = SystemSetting.order(:key)
    end

    def update
      @setting = SystemSetting.find(params[:id])
      if @setting.update(setting_params)
        redirect_to system_admin_settings_path, notice: "설정이 저장되었습니다."
      else
        @settings = SystemSetting.order(:key)
        render :index, status: :unprocessable_entity
      end
    end

    private

    def setting_params
      params.require(:system_setting).permit(:value)
    end
  end
end
