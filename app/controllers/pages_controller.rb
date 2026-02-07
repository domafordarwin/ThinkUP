class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if user_signed_in? && current_user.student?
      @current_session = current_user.learning_sessions.where.not(status: :completed).last
    end
  end
end
