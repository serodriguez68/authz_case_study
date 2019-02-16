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

  def after_sign_in_path_for(resource)
    services_path
  end
end
