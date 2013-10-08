class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by_username(params[:username])
		if user && user.authenticate(params[:password])
			if user.active
				session[:user_id] = user.id
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
		session[:user_id] = nil
		redirect_to home_path, notice: "Erfolgreich abgemeldet"
	end
end