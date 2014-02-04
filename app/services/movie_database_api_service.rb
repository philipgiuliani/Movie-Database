class MovieDatabaseAPIService
	attr_reader :api_key, :errors

	def initialize(options = {})
		@api_key = options[:api_key]
		@errors = []
	end

	def search_movie(name, release_year)
		if name.present? && release_year.present?
			search = api_request("search/movie", { query: name, primary_release_year: release_year, language: "DE" })
			if search
				if search["results"].any?
					movie_id = search["results"].first["id"]
					movie = api_request("movie/#{movie_id}", { language: "DE", append_to_response: "releases" })
					if movie && movie["status_code"] != 6
							# format the result
							age_rating = movie["releases"]["countries"].select { |country| country["iso_3166_1"] == "DE" }
							movie["age_rating"] = age_rating.first["certification"] unless age_rating.empty?
							movie["genres"] = genres_mapper(movie["genres"].map { |genre| genre["id"] })

							movie.to_json(only: ["id", "title", "backdrop_path", "age_rating", "overview", "genres"])
					else
						@errors << "Der Film konnte nicht gefunden werden"
					end
				else
					@errors << "Der Film konnte nicht gefunden werden"
				end
			else
				@errors << "Es konnte keine Verbindung zu der API hergestellt werden"
			end
		else
			@errors << "Name und das Erscheinungsjahr darf nicht leer sein"
		end
	end

	private

	def api_request(url, params)
		params = params.merge(api_key: @api_key).to_query
		request = Net::HTTP.get(URI.parse(URI.encode("http://api.themoviedb.org/3/#{url}?#{params}"))) rescue false
		if request
			JSON.parse request
		else
			false
		end
	end

	def genres_mapper(genres_array)
		mapper = [
			[1,12], # Abenteuer
			[2,28], # Action
			[3,16], # Animation
			[4,99], # Dokumentarfilm
			[5,18], # Drama
			[6,10751], # Familie
			[7,82], # Eastern
			[8,14], # Fantasy
			[9,36], # Geschichte
			[10,27], # Horror
			[11,35], # Komödie
			[12,80], # Krimi
			[13,53], # Thriller
			[14,878], # Science Fiction
			[15,10749], # Lovestory
			[16,9648], # Mystery
			[18,9805], # Sport
			[19,37], # Western
			[20,10595], # Holiday
			[21,1115] # Road Movie
		]

		genres_array.map do |genre_id|
			subarr = mapper.rassoc genre_id
			subarr[0] if subarr
		end.compact
	end
end
