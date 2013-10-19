jQuery ->
	$(document).on "ajax:success", "#toggle_button a", (e, data, status, xhr) ->
		$("#toggle_button").html data