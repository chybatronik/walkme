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

  save:->
    name = $(".name_edit").attr("value")
    text = $(".text_edit").text()
    console.log name, text, 
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
