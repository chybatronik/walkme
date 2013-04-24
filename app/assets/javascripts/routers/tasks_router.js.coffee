class WalkMe.Routers.Tasks extends Backbone.Router
  routes:
    "app/demo": "index"
    "app/demo/base": "base"
    
  index: ->
    console.log  "url index"   
    App.Models.user = new App.Models.User({id: 1})
    App.Models.user.fetch({async:false})
    if not App.Models.user.get("token")?
      App.Views.mainLayout.setView(".content",
        new App.Views.LoginView(model:App.Models.user)
      ).render()
    else
      App.router.navigate('/app/demo/base', {trigger: true})

  base: ->
    console.log  "url base"  
    App.Models.user.fetch({async:false}) 
    if App.Models.user?
      App.Views.mainLayout.setView(".content",
        new App.Views.NavigationView(user:App.Models.user)
      ).render()