#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require underscore
#= require backbone
#= require backbone.layoutmanager
#= require backbone.localStorage
#= require global

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

App.BeamRouter = Backbone.Router.extend(
  routes:
    "": "index"

  index: ->
    # Load the top albums.
    # Should be really recentAlbums
    # FIXME: This class of AlbumCollection really needs to be refactored
    # between all the listing.
    console.log  "index"   
)

#Equivalent of: $(function() {
$ ->
  #App.user = new App.Models.User()
  App.router = app  = new App.BeamRouter()
  App.Models.mainPage = new App.Models.MainPage(title: "Test title")
  #App.Views.searchForm = new App.Views.SearchFormView()
  App.Views.mainLayout = new App.Views.MainLayout(model: App.Models.mainPage)
  $("#demo").empty().append App.Views.mainLayout.el

  Backbone.history.start pushState: true
