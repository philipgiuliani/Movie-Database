class WishesController < ApplicationController
	before_filter :require_login
	before_filter :require_admin, only: [:update, :edit, :destroy]

	def index
		@wishes_opened = Wish.where("status != ?", "finished").order("updated_at desc").includes(:created_by_id)
		@wishes_completed = Wish.where("status = ?", "finished").order("updated_at desc").limit("0,5").includes(:created_by_id)
	end

	def new
		@wish = Wish.new
	end

	def create
		@wish = Wish.new(wish_params_create)
		if @wish.save
			redirect_to wishes_path, notice: "Der Wunsch wurde erfolgreich erstellt"
		else
			render "new"
		end
	end

	def edit
		@wish = Wish.find(params[:id])
	end

	def update
		@wish = Wish.find(params[:id])
		if @wish.update_attributes(wish_params_update)
			redirect_to wishes_path, notice: "Der Wunsch wurde erfolgreich aktualisiert"
		else
			render "edit"
		end
	end
	
	def destroy
		@wish = Wish.find(params[:id])
		@wish.destroy
		redirect_to wishes_path, notice: "Der Wunsch wurde erfolgreich gelöscht"
	end

	private

	def wish_params_create
		params.require(:wish).permit(:movie_title, :priority, :status).merge(editing_user: current_user)
	end

	def wish_params_update
		params.require(:wish).permit(:movie_title, :priority, :status, :movie_id).merge(editing_user: current_user)
	end
end