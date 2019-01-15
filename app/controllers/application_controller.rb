class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :current_client, :current_driver

  private
  def current_client
    current_user.try(:client)
  end

  def current_driver
    current_user.try(:driver)
  end
end
