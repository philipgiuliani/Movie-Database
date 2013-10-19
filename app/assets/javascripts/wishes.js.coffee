# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
	update_status = ->
		status_value = $('.edit_wish #wish_status').val()
		movie_field = $('.edit_wish #wish_movie_id').parent('p')
		if status_value == 'finished'
			movie_field.css('display', 'block')
		else
			movie_field.find('input').val('')
			movie_field.css('display', 'none')

	$(document).on 'change', '.edit_wish #wish_status', update_status

	$(document).on 'ready page:load', ->
		update_status()