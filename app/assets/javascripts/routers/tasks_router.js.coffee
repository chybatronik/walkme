class WalkMe.Routers.Tasks extends Backbone.Router
  routes:
    "app/demo": "index"
    "app/demo/login": "login"
    
  login: ->
    console.log  "url login"    
    WalkMe.Models.user.fetch({async:false})
    #WalkMe.Models.user.set("token", "UEoJRPJV12xjvCxAvmP7")
    #WalkMe.Models.user.set("email", "user@example.com")
    #WalkMe.Models.user.save()
    if not WalkMe.Models.user.get("token")?
      login = new WalkMe.Views.UsersLogin(model:WalkMe.Models.user)
      $("#demo-widget").append(login.render().el)
    else
      WalkMe.Routers.app.navigate('/app/demo', {trigger: true})

  index: ->
    console.log  "url index"  
    WalkMe.Models.user = new WalkMe.Models.User({id: 1})
    WalkMe.Models.user.fetch({async:false})

    if WalkMe.Models.user.get("token")?
      WalkMe.token = WalkMe.Models.user.get("token")
      WalkMe.Collections.catalogs = new WalkMe.Collections.Catalogs()

      WalkMe.Collections.catalogs.fetch({async:false})
      WalkMe.Views.navig_view = new WalkMe.Views.Navigate(
        model:WalkMe.Models.user
        collection:WalkMe.Collections.catalogs
      )
      $("#demo-widget").empty().append(WalkMe.Views.navig_view.render().el)
    else
      WalkMe.Routers.app.navigate('/app/demo/login', {trigger: true})