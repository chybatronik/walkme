####
#User
####
class User
  set:(data)->
    @token = data.token
    @email = data.email

user = new User
##############
#controllers
##############

main = ->
  #login()
  $('.main').empty()
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
    console.log "initialize LoginView", user.token

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
        ###token = data.token
        email = data.email###
        user.set(data)
        main()
      )

  render:->
    this.$el.html(this.template());
    $('.main').empty().append(this.el)
)

###########
###CollectionStepView = Backbone.View.extend(
  template: _.template($('#collection_step_view').html())

  initialize:->   
    _.bindAll @
    @.render()
    console.log "initialize CollectionStepView"

  render:->
    collection = ['asd', 'asdasd', 'asdasdasd']
    #this.$el.html(this.template());
    this.$el.append( this.template() );
    $('#workspace-panel').empty().append(this.el)
)###
###########

NavigationView = Backbone.View.extend(
  template: _.template($('#navigation_view').html())

  initialize:->   
    _.bindAll @
    @.render()
    console.log "initialize NavigationView", user.token

  events:
    "click #help": "help"
    "click #workspace": "workspace"
    "click #setting": "setting"
    "click #publish": "publish"
    "click #logout": "logout"
    "click #start": "start"
    "click #stop": "stop"

  start:(ev)->
    ev.preventDefault()
    send_content_script("start")

  stop:(ev)->
    ev.preventDefault()
    send_content_script("stop")

  help:(ev)->
    ev.preventDefault()

  workspace:(ev)->
    console.log "workspace", ev.target, $(ev.target).attr('id')

  setting:(ev)->
    console.log "setting", ev.target, $(ev.target).attr('id')

  publish:(ev)->
    console.log "publish", ev.target, $(ev.target).attr('id')

  logout:(ev)->
    console.log "logout", ev.target, $(ev.target).attr('id')

  render:->
    this.$el.html(this.template({name: user.email}));
    $('.navigation').empty().append(this.el)
)

send_content_script = (action) =>
  chrome.tabs.query({"status":"complete","windowId":chrome.windows.WINDOW_ID_CURRENT,"active":true}, 
    (tabs)=>
      console.log(JSON.stringify(tabs[0]))
      console.log(tabs[0].id)
      chrome.tabs.sendMessage(tabs[0].id, {action : action}) 
  )

$(window).load(login)
