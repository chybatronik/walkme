###########

App.Models.User = Backbone.Model.extend(
  localStorage: new Backbone.LocalStorage("App_Model_User")
)
###########

App.Views.LoginView = Backbone.View.extend(
  manage: true
  template: '#login-form'

  initialize:()->   
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
      success: @.save
    )

  save:(data, status, response)->
    console.log {token : data.token, email : data.email}
    @model.set({token : data.token, email : data.email})
    @model.save()
    console.log "save user"
    App.router.navigate('/app/demo/base', {
          trigger: true
        })

  serialize: ->
    @model.toJSON()
)

###########