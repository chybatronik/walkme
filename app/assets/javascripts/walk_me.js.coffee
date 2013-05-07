window.WalkMe =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Actions: {}
  current_catalog_id:null
  token:null
  initialize: -> 
    WalkMe.Routers.app = new WalkMe.Routers.Tasks()
    Backbone.history.start pushState: true

_.templateSettings =
  interpolate: /\{\{\=(.+?)\}\}/g
  evaluate: /\{\{(.+?)\}\}/g
  
$(document).ready ->
  WalkMe.initialize()
  $("#button_walkme").on("click", (e)->
    e.preventDefault()
    e.stopPropagation()
    console.log "Walkme click"
    if $(".demo-widget").is(":visible")
      $(".demo-widget").hide()
    else
      if WalkMe.Collections.tasks 
        WalkMe.Collections.tasks.fetch({async:false})
        WalkMe.Actions.stop()
      $("#button_walkme").text("WalkMe")
      $("#button_walkme").removeClass("btn-large")
      $(".demo-widget").show()
  )
