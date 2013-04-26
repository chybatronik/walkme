class WalkMe.Routers.Tasks extends Backbone.Router
  routes:
    "app/demo": "index"
    "app/demo/login": "login"
    
  login: ->
    console.log  "url login"   
    
    WalkMe.Models.user.fetch({async:false})
    if not WalkMe.Models.user.get("token")?
      login = new WalkMe.Views.UsersLogin(model:WalkMe.Models.user)
      $("#demo-widget").append(login.render().el)
    else
      WalkMe.Routers.app.navigate('/app/demo', {trigger: true})

  index: ->
    console.log  "url index"  
    WalkMe.Models.user = new WalkMe.Models.User({id: 1})

    #for demo page
    WalkMe.Models.user.set("token", "token")
    WalkMe.Models.user.set("email", "email@email.demo")
    WalkMe.Models.user.save()

    #WalkMe.Models.user.fetch({async:false}) 
    if WalkMe.Models.user.get("token")?
      WalkMe.Views.navig_view = new WalkMe.Views.Navigate(model:WalkMe.Models.user)
      $("#demo-widget").empty().append(WalkMe.Views.navig_view.render().el)
      #text = WalkMe.Views.navig_view.render().$el.html()
      #$("#demo-widget").attr('data-original-title', "name")
      #$("#demo-widget").attr('data-html', true)
      ##$("#demo-widget").attr('data-placement', "bottom")
      #$("#demo-widget").attr('data-content', text)
      #$("#demo-widget").popover('show');
    else
      WalkMe.Routers.app.navigate('/app/demo/login', {trigger: true})