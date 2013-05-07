class WalkMe.Views.UsersLogin extends Backbone.View

  template: JST['users/login']

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
        email:  $('#demo-widget input.email').val()
        password: $('#demo-widget input.password').val()
      success: @.save
      error: ->
        $(".alert.error_login").show()

    )

  save:(data, status, response)->
    @model.set({token : data.token, email : data.email})
    @model.save()
    WalkMe.Routers.app.navigate('/app/demo', {trigger: true})

  render:()->
    $(@el).html(@template())
    this


