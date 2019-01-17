class VisitorsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @users = User.order(email: :asc).includes(:roles)
  end

  def about
  end
end
