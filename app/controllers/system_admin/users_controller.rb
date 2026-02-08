module SystemAdmin
  class UsersController < BaseController
    before_action :set_user, only: [:show, :edit, :update]

    def index
      @users = User.order(:role, :name)
      @users = @users.where(role: params[:role]) if params[:role].present?
    end

    def show
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to system_admin_user_path(@user), notice: "사용자가 생성되었습니다."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      update_params = user_params
      update_params = update_params.except(:password) if update_params[:password].blank?
      if @user.update(update_params)
        redirect_to system_admin_user_path(@user), notice: "사용자 정보가 수정되었습니다."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :role, :grade_level, :thinking_level)
    end
  end
end
