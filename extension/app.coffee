
jQuery ($) ->
  # your code here!
	console.log "hello world"
	$("input.btn.btn-primary").click (evt)->
		evt.preventDefault()
		$.post 'http://127.0.0.1:3000/api/v1/tokens.json', contentType: "application/x-www-form-urlencoded",
			email:  $('.email').text()
			password: $('.password').text()
			(data) -> $('.token').append data