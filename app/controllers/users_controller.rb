class UsersController < ApplicationController
  before_filter :require_login, only: [:index, :show, :edit, :update]

  def index
  	@users = User.all(order: "firstname, lastname asc")
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