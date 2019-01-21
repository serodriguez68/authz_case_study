class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include Authz::Controllers::AuthorizationManager
  rescue_from Authz::Controllers::AuthorizationManager::NotAuthorized, with: :unauthorized_handler

  helper_method :current_client, :current_driver

  private
  def current_client
    current_user.try(:client)
  end

  def current_driver
    current_user.try(:driver)
  end

  def unauthorized_handler
    msg = 'Ooops! It seems that you are not authorized to do that!'
    respond_to do |format|
      format.html { redirect_back fallback_location: main_app.root_url, alert: msg }
      format.js{ render(js: "alert('#{msg}');") }
    end
  end
end
