token = ""

login = ->
	login_template = _.template($('#login-form').html())
	$('.login').append(login_template())
	$("input.btn.btn-primary").click (evt)->
		evt.preventDefault()
		$.ajax 
			url : 'http://127.0.0.1:3000/api/v1/tokens.json'
			type : "POST"
			dataType: "json"
			data:
				email:  $('input.email').val()
				password: $('input.password').val()
			success: (data, status, response) ->
				console.log data, status, response
				token data.token
				$('.token').append data.token

main = ->
	login()

$(window).load(main)