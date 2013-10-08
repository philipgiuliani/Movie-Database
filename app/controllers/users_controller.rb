class UsersController < ApplicationController
  before_filter :require_login, only: [:index, :show, :edit, :update]

  def index
  	@users = User.all(order: "firstname, lastname asc", conditions: {active: true})
  	@users_not_active = User.all(order: "firstname, lastname asc", conditions: {active: false}) if current_user.is_admin?
  end

  def show
    @user = User.find(params[:id])
  end

	def new
		@user = User.new
	end

	def edit
		@user = User.find(params[:id])
		if current_user.id != @user.id
			redirect_to movies_path, alert: "Sie dürfen dieses Profil nicht bearbeiten"
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
      redirect_to edit_user_path, notice: "Profil bearbeitet"
  	else
  	  render "edit"
  	end
	end

	def destroy
		user = User.find(params[:id])
		if current_user.is_admin?
			user.destroy
			redirect_to users_path, notice: "Der Benutzer wurde erfolgreich gelöscht"
		else
			redirect_to users_path, notice: "Keine Berechtigungen"
		end
	end

	def activate
		user = User.find(params[:id])
		if current_user.is_admin?
			user.update_attributes(active: true)
			redirect_to users_path, notice: "Der Benutzer wurde erfolgreich aktiviert"
		else
			redirect_to users_path, notice: "Keine Berechtigungen"
		end
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to login_path, notice: "Erfolgreich registriert"
		else
			render "new"
		end
	end

	private

	def user_params
		params.require(:user).permit(:username, :firstname, :lastname, :password, :password_confirmation, :avatar)
	end
end