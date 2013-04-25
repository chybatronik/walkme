class WalkMe.Routers.Tasks extends Backbone.Router
  routes:
    "app/demo": "index"
    "app/demo/base": "base"
    
  index: ->
    console.log  "url index"   
    WalkMe.Models.user = new WalkMe.Models.User({id: 1})
    WalkMe.Models.user.fetch({async:false})
    if not WalkMe.Models.user.get("token")?
      login = new WalkMe.Views.UsersLogin(model:WalkMe.Models.user)
      $("#demo-widget").append(login.render().el)
    else
      WalkMe.Routers.app.navigate('/app/demo/base', {trigger: true})

  base: ->
    console.log  "url base"  
    WalkMe.Models.user.fetch({async:false}) 
    if WalkMe.Models.user?
      WalkMe.Views.navig_view = new WalkMe.Views.Navigate(model:WalkMe.Models.user)
      $("#demo-widget").empty().append(WalkMe.Views.navig_view.render().el)