module Parent
  class ChildrenController < ApplicationController
    before_action :authorize_parent!

    def index
      @children = current_user.children.includes(:learning_sessions)
    end

    def show
      @child = current_user.children.find(params[:id])
      @stats = DashboardStats.new(@child).call
      @sessions = @child.learning_sessions.completed
        .includes(:passage, :session_summary)
        .order(created_at: :desc)
        .limit(10)
    end

    private

    def authorize_parent!
      unless current_user.parent?
        redirect_to root_path, alert: "학부모만 접근할 수 있습니다."
      end
    end
  end
end
