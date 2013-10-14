class StatusesController < ApplicationController
	def create
		@status = current_user.statuses.build(status_params)
		if @status.save
			redirect_to home_path, notice: "Status erfolgreich verfasst"
		else
			redirect_to home_path, alert: "Status konnte nicht gespeichert werden, da er zu kurz war!"
		end
	end

	private

	def status_params
		params.require(:status).permit(:comment)
	end
end