class UsersController < ApplicationController
  before_filter :require_login, only: [:index, :show, :edit, :update]
  before_filter :require_admin, only: [:activate, :destroy]

  def index
  	@users = User.all(order: "firstname, lastname asc", conditions: {active: true})
  	@users_not_active = User.all(order: "firstname, lastname asc", conditions: {active: false}) if current_user.is_admin?
  end

  def show
    @user = User.find(params[:id])
    last_ratings = @user.ratings.order("created_at desc").limit("0,8")
    movies_seen = @user.seen_movies.order("created_at desc").limit("0,8")
    last_statuses = @user.statuses.order("created_at desc").limit("0,8")
		last_wishes = Wish.where("created_by_id = ?", @user.id).order("created_at desc").limit("0,8")
    @last_activities = (last_ratings + movies_seen + last_statuses + last_wishes).sort{|b,a| a.created_at <=> b.created_at }[0..7]
  end

	def new
		if current_user
			redirect_to movies_path, alert: "Sie sind bereits eingeloggt"
		else
			@user = User.new
		end
	end

	def edit
		@user = User.find(params[:id])
		if current_user.id != @user.id
			redirect_to movies_path, alert: "Sie dürfen dieses Profil nicht bearbeiten"
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params_edit)
      redirect_to edit_user_path, notice: "Profil bearbeitet"
  	else
  	  render "edit"
  	end
	end

	def destroy
		user = User.find(params[:id])
		user.destroy
		redirect_to users_path, notice: "Der Benutzer wurde erfolgreich gelöscht"
	end

	def activate
		user = User.find(params[:id])
		user.update_attributes(active: true)
		
		redirect_to users_path, notice: "Der Benutzer wurde erfolgreich aktiviert"
	end

	def create
		@user = User.new(user_params_create)
		if @user.save
			redirect_to login_path, notice: "Sie haben sich erfolgreich registriert. Ihr Konto muss erst von einem Administrator aktiviert werden."
		else
			render "new"
		end
	end

	private

	def user_params_create
		params.require(:user).permit(:username, :firstname, :lastname, :email, :password, :password_confirmation)
	end

	def user_params_edit
		params.require(:user).permit(:username, :firstname, :lastname, :email, :newsletter, :password, :password_confirmation, :avatar, :highlights_view)
	end
end