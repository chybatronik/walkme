class WalkMe.Views.Task extends Backbone.View

  template: _.template(JST['templates/tasks/task']())
  tagName: "li"

  initialize:->
    _.bindAll @
    @model.on("change", @render, @)
    @model.on("remove", @delete, @)

  delete:->
    @.remove()
    
  render: ->
    $(@el).html(@template(@model.toJSON()))
    this
