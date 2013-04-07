token = ""

##############
#controllers
##############

main = ->
	#login()
	navigateview = new NavigationView();

login = ->
	loginview = new LoginView();


###############
# VIEW
###############

LoginView = Backbone.View.extend(
	template: _.template($('#login-form').html())

	initialize:->  	
		_.bindAll @
		@.render()
		console.log "initialize LoginView", token

	events:
		"click #submit": "get_token"

	get_token:(evt)->	
		evt.preventDefault()
		$.ajax(
			url : 'http://127.0.0.1:3000/api/v1/tokens.json'
			type : "POST"
			dataType: "json"
			data:
				email:  $('input.email').val()
				password: $('input.password').val()
			success: (data, status, response) ->
				token = data.token
				main()
			)

	render:->
		this.$el.html(this.template());
		$('.main').empty().append(this.el)
)

###########

NavigationView = Backbone.View.extend(
  template: _.template($('#joinview').html())

  initialize:->  	
  	_.bindAll @
  	@.render()
  	console.log "initialize NavigationView", token

  events:
    "click #help": "help"
    "click #workspace": "workspace"
    "click #setting": "setting"
    "click #publish": "publish"
    "click #logout": "logout"

  help:(ev)->
  	ev.preventDefault()
  	console.log "HELP", ev.target, $(ev.target).attr('id')

  workspace:(ev)->
  	console.log "workspace", ev.target, $(ev.target).attr('id')

  setting:(ev)->
  	console.log "setting", ev.target, $(ev.target).attr('id')

  publish:(ev)->
  	console.log "publish", ev.target, $(ev.target).attr('id')

  logout:(ev)->
  	console.log "logout", ev.target, $(ev.target).attr('id')

  render:->
  	this.$el.html(this.template());
  	$('.navigation').empty().append(this.el)
)

$(window).load(login)