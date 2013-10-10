class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :user_signed_in?

  private

  def current_user
  	if session[:user_id]
  		@current_user ||= User.find(session[:user_id])
    end
  end

  def user_signed_in?
    current_user.present?
  end

  def require_login
    unless user_signed_in?
      redirect_to login_path, alert: "Bitte melden Sie sich zuerst an."
    end
  end

  def require_admin
    unless user_signed_in? && current_user.is_admin?
      redirect_to users_path, alert: "Keine Berechtigung"
    end
  end
end