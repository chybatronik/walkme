###########

App.Models.User = Backbone.Model.extend(
  localStorage: new Backbone.LocalStorage("App_Model_User")

  set_user:(data)->
    @token = data.token
    @email = data.email
    console.log "asdadasdads"
    this.set({token : data.token, email : data.email})
  
  get_user:->
    token = this.get('token')
    email = this.get('email')
    console.log "get user", token, email
      
    if not token?
      false
    else
      @token = token
      @email = email
      true
)
###########

App.Views.LoginView = Backbone.View.extend(
  manage: true
  template: '#login-form'

  initialize:->   
    _.bindAll @
    console.log "initialize LoginView", @model.get("token")

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
        user.set_user(data)
      )

  serialize: ->
    @model.toJSON()
)

###########