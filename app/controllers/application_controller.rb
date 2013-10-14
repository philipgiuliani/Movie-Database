class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	skip_before_filter :verify_authenticity_token
	helper_method :user_signed_in?

	private

	def current_user
		@current_user ||= User.find_by_username_and_password_digest(cookies[:auth_user], cookies[:auth_password]) if (cookies[:auth_user] && cookies[:auth_password])
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
			redirect_to movies_path, alert: "Keine Berechtigung"
		end
	end
end