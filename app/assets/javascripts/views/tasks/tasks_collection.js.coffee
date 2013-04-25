class WalkMe.Views.TasksCollection extends Backbone.View

  template: JST['tasks/collection']
  tagName:"ol"

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @addOneTask, this)
    @.$el.append(@template())

  render: ->
    @collection.each(@addOneTask, @)    
    @

  addOneTask:(model)->
    task_vew = new WalkMe.Views.Task(model:model)
    @.$el.find(".main").append(task_vew.render().el)
