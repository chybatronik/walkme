class User
  set:(data)->
    @token = data.token
    @email = data.email
    console.log "asdadasdads"
    chrome.storage.sync.set({'user':JSON.stringify({token : data.token, email : data.email})}, =>
      console.log('SAVE user')
    )
  get:->
    chrome.storage.sync.get('user', (storage)=>
      console.log "get user", storage
      
      if not storage.user?
        loginview = new LoginView();
      else
        stored = JSON.parse(storage.user)
        console.log stored
        @token = stored.token
        @email = stored.email
        main()
    )
  delete:->
    chrome.storage.sync.set({'user':null}, =>
      console.log('delete user')
    )
###########

App.Model.User = Backbone.Model.extend(
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

App.View.LoginView = Backbone.View.extend(
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
      url : 'http://walkme.aws.af.cm/api/v1/tokens.json'
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