class UserMailer < ActionMailer::Base
	default from: "meinefilme.net <newsletter@meinefilme.net>"

	def weekly_movies_email(user, movies)
		@movies = movies
		@user = user
		unless user.email.blank?
			mail(to: user.email, subject: "Neue Filme der #{Time.now.strftime("%W")}. Woche #{Time.now.year}")
		end
	end
end