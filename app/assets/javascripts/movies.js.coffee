jQuery ->
	$(document).on "ajax:success", "#toggle_button a", (e, data, status, xhr) ->
		$("#toggle_button").replaceWith data

	$(document).on "ajax:success", "#vote_button a", (e, data, status, xhr) ->
		$("#vote_button").replaceWith data
		$(".tooltip").tipTip
			delay: 50
		$(".tooltip").removeClass ".tooltip"

	$(document).on 'ready page:load', ->
		$(".tooltip").tipTip
			delay: 50
		$(".tooltip").removeClass ".tooltip"

	$(document).on "click", "#synchronize", (event) ->
		event.preventDefault()
		button = this
		url = $(this).attr("data_url")
		title = $("input[name='movie[title]']").val()
		release_year = $("select[name='movie[release_year]']").val()
		$.ajax url,
			type: "POST"
			data:
				name: title
				release_year: release_year

			beforeSend: ->
				$("form").find("div.notification").remove()
				$(button).attr "disabled", "disabled"
				$(button).text "Lädt..."

			success: (data) ->
				$("form").prepend "<div class='notification success'>Erfolgreich Synchronisiert</div>"
				$("select[name='movie[age_rating]']").val data.age_rating  if data.age_rating
				$("textarea[name='movie[description]']").val data.overview  if data.overview
				$("input[name='movie[genre_ids][]']").prop "checked", false
				$.each data.genres, (i, genre_id) ->
					$("input[name='movie[genre_ids][]'][value=" + genre_id + "]").prop "checked", true


			error: (data) ->
				$("form").prepend "<div class='notification error'>" + data.responseJSON.errors.join(", ") + "</div>"

			complete: ->
				$(button).removeAttr "disabled"
				$(button).text "Synchronisieren"

	$(document).on "click", ".movie_description_text > a", (event) ->
		event.preventDefault()
		button = $(this)
		description = $(".movie_description_text > div")
		if description.hasClass "collapsed"
			description.removeClass "collapsed"
			button.remove()