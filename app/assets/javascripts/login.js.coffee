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

  events:
    "click #submit": "get_token"

  get_token:(evt)-> 
    evt.preventDefault()

    $.ajax(
      url : "#{document.location.origin}/api/v1/tokens.json"
      type : "POST"
      dataType: "json"
      data:
        email:  $('input.email').val()
        password: $('input.password').val()
      success: @.save
    )

  save:(data, status, response)->
    @model.set({token : data.token, email : data.email})
    @model.save()
    App.router.navigate('/app/demo/base', {trigger: true})

  serialize: ->
    @model.toJSON()
)

###########