#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require underscore
#= require backbone
#= require backbone.layoutmanager
#= require backbone.localStorage
#= require global
#= require page
#= require introjs

App.Models.MainPage = Backbone.Model.extend({})

App.Views.ContentView = Backbone.View.extend(
  manage: true
  template: "#content-view"

  #serialize: ->
    #@model.toJSON()
)

App.Views.MainLayout = Backbone.View.extend(
  manage: true
  template: "#container-fluid"

  views: {
    '.content': new App.Views.ContentView()
  }
)

App.WalkMeRouter = Backbone.Router.extend(
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
)

#Equivalent of: $(function() {
$ ->
  #App.user = new App.Models.User()
  App.router = app  = new App.WalkMeRouter()
  App.Models.mainPage = new App.Models.MainPage(title: "Test title")
  #App.Views.searchForm = new App.Views.SearchFormView()
  App.Views.mainLayout = new App.Views.MainLayout(model: App.Models.mainPage)
  $("#demo").empty().append App.Views.mainLayout.el
  App.Views.mainLayout.render()
  Backbone.history.start pushState: true
