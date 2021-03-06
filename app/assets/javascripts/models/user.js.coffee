class WalkMe.Models.User extends Backbone.Model
  localStorage: new Backbone.LocalStorage("App_Model_User")  

  defaults:
    ballon:"#FFFFFF"
    header:"#FFFFFF"
    content:"#FFFFFF"
    button:"#ececec"
    button_text:"#333"

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
    user = WalkMe.Models.user
    #console.log "{token : data.token, email : data.email}", {token : data.token, email : data.email}
    user.set({token : data.token, email : data.email, user_id : data.user_id})
    user.set("password", "")
    user.save()
