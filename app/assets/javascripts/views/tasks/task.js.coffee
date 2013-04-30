class WalkMe.Views.Task extends Backbone.View

  template: _.template(JST['templates/tasks/task']())
  edit_task: _.template(JST['templates/tasks/edit_task']())
  tagName :"tr"
  className:"inline"

  events:
    "click #edit": "show_edit_form"
    "click #save": "save"
    "click #cancel": "cancel"
    "click #delete": "del"

  initialize:->
    _.bindAll @
    @model.on("change", @render, @)
    @model.on("remove", @delete, @)

  cancel:(e)->
    e.preventDefault()
    $(@el).html(@template(@model.toJSON()))
    this

  save:(e)->
    e.preventDefault()

    name = @.$el.find("#name").val()
    text = @.$el.find("#text").val()
    
    @model.set("name", name)
    @model.set("text", text)
    @model.save()

  show_edit_form:->
    $(@el).html(@edit_task(@model.toJSON()))
    this

  del:->
    @model.destroy()

  delete:->
    @.remove()
    
  render: ->
    $(@el).html(@template(@model.toJSON()))
    this
