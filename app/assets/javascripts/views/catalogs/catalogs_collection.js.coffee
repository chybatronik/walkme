class WalkMe.Views.CatalogsCollection extends Backbone.View

  template: JST['catalogs/collection']

  events:
    "click #clear_data": "clear_data"

  initialize: ->
    _.bindAll @
    @collection.on('reset', @render, this)
    @collection.on('add', @addOneTask, this)
    @.$el.append(@template())
    
  clear_data:(e)->
    e.preventDefault()
    e.stopPropagation()
    #send_content_script("clear")
    @collection.delete_all()

  render: ->
    #@.$el.append(@template())
    @collection.each(@addOneTask, @)   
    @

  addOneTask:(model)->
    task_vew = new WalkMe.Views.Task(model:model)
    @.$el.find(".main").append(task_vew.render().el)

    