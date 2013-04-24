App.Models.Task = Backbone.Model.extend(
)

App.Views.TaskView = Backbone.View.extend(
  template: _.template($('#task').html())
  tagName: "li"

  initialize:(@model)->   
    _.bindAll @
    @model.on("change", @.render)

  render:()->
    temp = @.template(@model.toJSON())
    @.$el.html(temp)
    @
)

App.Collections.TaskCollection = Backbone.Collection.extend(
  localStorage: new Backbone.LocalStorage("App_Collection_Task")
)

App.Views.TaskCollectionView = Backbone.View.extend(
  manage: true
  template: '#task-list'
  model: App.Models.Task

  events:
    "click #start": "start"
    "click #stop": "stop"
    "click #play": "play"
    "click #clear_data": "clear_data"

  initialize:()->   
    _.bindAll @
    @collection.on("change reset add remove", =>
      console.log "@collection beforender"
      @beforeRender()
    , @)

  start:(ev)->
    ev.preventDefault()
    send_content_script("start")

  stop:(ev)->
    ev.preventDefault()
    send_content_script("stop")

  play:(ev)->
    ev.preventDefault()
    send_content_script("play")

  
  clear_data:(ev)->
    ev.preventDefault()
    send_content_script("clear")

  beforeRender:->
    @collection.each ((model) ->
      @insertView("ul", new App.Views.TaskView(
        model: new App.Models.Task(model)
      )).render()
    ), this

  serialize: ->
    @collection.toJSON()
)

send_content_script = (action, stored=null) =>
  console.log "send_content_script", action

  switch action
    when "start"
      App.Actions.start()
    when "stop"
      App.Actions.stop()
    when "play"
      App.Actions.play()
    when "clear"
      console.log "clear"
      list_task = new App.Collections.TaskCollection()
      list_task.fetch({async:false})
      array = list_task.toArray()
      for model in array
        console.log "each list_task", model
        model.destroy()
      console.log list_task