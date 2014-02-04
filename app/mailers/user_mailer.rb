class UserMailer < ActionMailer::Base
	default from: "meinefilme.net <newsletter@meinefilme.net>"

	def weekly_movies_email(user, movies)
		@movies = movies
		@user = user
		mail(to: user.email, subject: "Neue Filme der #{Date.today.cweek}. Woche #{Date.today.year}") unless user.email.blank?
	end
end
