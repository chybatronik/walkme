class WalkMe.Views.Task extends Backbone.View

  template: _.template(JST['templates/tasks/task']())
  tagName :"tr"
  className:"inline"

  events:
    "click #edit": "edit"
    "click #delete": "del"

  initialize:->
    _.bindAll @
    @model.on("change", @render, @)
    @model.on("remove", @delete, @)

  del:->
    @model.destroy()
    
  delete:->
    @.remove()
    
  render: ->
    $(@el).html(@template(@model.toJSON()))
    this
