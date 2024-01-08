class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to main_app.root_url, alert: exception.message }
    end
  end

  include Pagy::Backend

  before_action :authenticate_user!
  protect_from_forgery
end
