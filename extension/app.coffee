token = ""

login = ->
	login_template = _.template($('#login-form').html())
	$('.main').empty().append(login_template())
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
				token = data.token
				$('.main').empty().append data.token

main = ->
	#login()
	navigateview = new NavigationView();

###############
# VIEW
###############
NavigationView = Backbone.View.extend(
  template: _.template($('#joinview').html())


  initialize:->  	
  	_.bindAll @
  	@.render()
  	console.log "initialize"

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

$(window).load(main)