class UserMailer < ActionMailer::Base
	default from: "meinefilme.net <newsletter@meinefilme.net>"

	def weekly_movies_email(user, movies)
		@movies = movies
		@user = user
		unless user.email.blank?
			mail(to: user.email, subject: "Neue Filme der #{Date.today.cweek}. Woche #{Time.today.year}")
		end
	end
end