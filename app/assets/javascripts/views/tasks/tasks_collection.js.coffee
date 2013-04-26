class WalkMe.Views.TasksCollection extends Backbone.View

  template: JST['tasks/collection']
  tagName:"ol"

  events:
    "click #start": "start"
    "click #stop": "stop"
    "click #play": "play"
    "click #clear_data": "clear_data"

  initialize: ->
    _.bindAll @
    @collection.on('reset', @render, this)
    @collection.on('add', @addOneTask, this)
    @.$el.append(@template())
    
  start:(e)->
    console.log "start"
    #e.preventDefault()
    e.preventDefault()
    e.stopPropagation()
    send_content_script("start")

  stop:(e)->
    console.log "stop"
    e.preventDefault()
    e.stopPropagation()
    send_content_script("stop")

  play:(e)->
    console.log "play"
    e.preventDefault()
    e.stopPropagation()
    send_content_script("play")

  clear_data:(e)->
    e.preventDefault()
    e.stopPropagation()
    send_content_script("clear")

  render: ->
    #@.$el.append(@template())
    @collection.each(@addOneTask, @)   
    @

  addOneTask:(model)->
    task_vew = new WalkMe.Views.Task(model:model)
    @.$el.find(".main").append(task_vew.render().el)

send_content_script = (action, stored=null) =>
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
      console.log list_task