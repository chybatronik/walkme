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
    @set({token : data.token, email : data.email})
    @set("password", "")
    @save()
