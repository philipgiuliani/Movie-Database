class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by_username(params[:username])
		if user && user.authenticate(params[:password])
			if user.active
				if params[:remember_me]
					cookies.permanent[:auth_user] = user.username
					cookies.permanent[:auth_password] = user.password_digest
				else
					cookies[:auth_user] = user.username
					cookies[:auth_password] = user.password_digest
				end
				redirect_to home_path, notice: "Erfolgreich eingeloggt"
			else
				flash.now.alert = "Das Benutzerkonto muss zuerst von einem Administrator aktiviert werden"
				render "new"
			end
		else
			flash.now.alert = "Fehlerhafter Benutzername oder Passwort"
			render "new"
		end
	end

	def destroy
		cookies.delete(:auth_user)
		cookies.delete(:auth_password)
		redirect_to home_path, notice: "Erfolgreich abgemeldet"
	end
end