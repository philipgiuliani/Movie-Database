onEndless = ->
	$(window).off 'scroll', onEndless
	if $("#activities").length
		url = $('.pagination .next_page').attr('href')
		if url && $(window).scrollTop() > $(document).height() - $(window).height() - 140
			$(".pagination").html('<div id="activities_loading">Aktivitäten werden geladen...</div>')
			$.getScript url, ->
				$(window).on 'scroll', onEndless
		else
			$(window).on 'scroll', onEndless

$(document).on 'ready page:load', ->
	$(window).on 'scroll', onEndless
	$(window).scroll()