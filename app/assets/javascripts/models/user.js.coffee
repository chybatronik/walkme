class WalkMe.Models.User extends Backbone.Model
  localStorage: new Backbone.LocalStorage("App_Model_User")  

  generate_token:->
    if @get("email") and @get("password")
      $.ajax(
        url : "#{document.location.origin}/api/v1/tokens.json"
        type : "POST"
        dataType: "json"
        data:
          email:  @get("email")
          password: @get("password")
        success: @.save_data
        error: ->
          console.log "ERROR generate_token"
      )

  save_data:(data, status, response)->
    user = new WalkMe.Models.User({id: 1})
    console.log "{token : data.token, email : data.email}", {token : data.token, email : data.email}
    user.set({token : data.token, email : data.email})
    user.set("password", "")
    user.save()
