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
  $("#button_walkme").on("click", (e)->
    e.preventDefault()
    e.stopPropagation()
    console.log "Walkme click"
    if $(".demo-widget").is(":visible")
      $(".demo-widget").hide()
    else
      WalkMe.Collections.tasks.fetch({async:false})
      WalkMe.Actions.stop()
      $("#button_walkme").text("WalkMe")
      $("#button_walkme").removeClass("btn-large")
      $(".demo-widget").show()
  )
