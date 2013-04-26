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
  ###$("#walkme").on("click",  (e)=>
    console.log "click walkme"
    $("#demo-widget").popover('toggle')
  )

  $("#start").on("click", (e)-> 
    console.log "start"
    e.preventDefault()
    e.stopPropagation()
    send_content_script("start")
  )
  $("#stop").on("click", (e)-> 
    console.log "stop"
    e.preventDefault()
    send_content_script("stop")
  )
  $("#play").on("click", (e)-> 
    console.log "play"
    e.preventDefault()
    send_content_script("play")
  )
  $("#clear_data").on("click", (e)-> 
    console.log "clear_data"
    e.preventDefault()
    send_content_script("clear")
  )###


###send_content_script = (action, stored=null) =>
  console.log "send_content_script", action

  switch action
    when "start"
      WalkMe.Actions.start()
    when "stop"
      WalkMe.Actions.stop()
    when "play"
      WalkMe.Actions.play()
    when "clear"
      console.log "clear"
      list_task = new WalkMe.Collections.Tasks()
      list_task.fetch({async:false})
      array = list_task.toArray()
      for model in array
        console.log "each list_task", model
        model.destroy()
      console.log list_task###