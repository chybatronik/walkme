window.WalkMe =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Actions: {}
  initialize: -> 
    WalkMe.Routers.app = new WalkMe.Routers.Tasks()
    Backbone.history.start pushState: true

_.templateSettings =
  interpolate: /\{\{\=(.+?)\}\}/g
  evaluate: /\{\{(.+?)\}\}/g
  
$(document).ready ->
  WalkMe.initialize()
  $("#walkme").on("click",  (e)=>
    console.log "click walkme"
    $("#demo-widget").popover('toggle')
  )
