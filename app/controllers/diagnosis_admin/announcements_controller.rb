module DiagnosisAdmin
  class AnnouncementsController < BaseController
    before_action :set_announcement, only: [:show, :edit, :update, :destroy]

    def index
      @announcements = Announcement.order(created_at: :desc).includes(:user)
    end

    def new
      @announcement = Announcement.new
    end

    def create
      @announcement = Announcement.new(announcement_params)
      @announcement.user = current_user

      if @announcement.save
        redirect_to diagnosis_admin_announcement_path(@announcement), notice: "공지사항이 등록되었습니다."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def update
      if @announcement.update(announcement_params)
        redirect_to diagnosis_admin_announcement_path(@announcement), notice: "공지사항이 수정되었습니다."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @announcement.destroy
      redirect_to diagnosis_admin_announcements_path, notice: "공지사항이 삭제되었습니다."
    end

    private

    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    def announcement_params
      params.require(:announcement).permit(:title, :content, :published_at)
    end
  end
end
