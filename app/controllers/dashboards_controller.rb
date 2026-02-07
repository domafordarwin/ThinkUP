class DashboardsController < ApplicationController
  def show
    @stats = DashboardStats.new(current_user).call
  end
end
