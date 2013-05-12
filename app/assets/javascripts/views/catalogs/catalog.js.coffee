class WalkMe.Views.Catalog extends Backbone.View

  template: _.template(JST['templates/catalogs/catalog']())
  edit_task: _.template(JST['templates/catalogs/edit_catalog']())
  tagName :"tr"
  className:"inline"

  events:
    "click #edit": "show_edit_form"
    "click #save": "save"
    "click #cancel": "cancel"
    "click #delete": "del"
    "click #public": "publication"

  initialize:->
    _.bindAll @
    @model.on("change", @render, @)
    @model.on("remove", @delete, @)

  cancel:(e)->
    e.preventDefault()
    $(@el).html(@template(@model.toJSON()))
    this

  publication:(e)->
    e.preventDefault()
    @model.make_public()

  save:(e)->
    e.preventDefault()

    name = @.$el.find("#name").val()
    #text = @.$el.find("#text").val()
    
    @model.set("name", name)
    #@model.set("text", text)
    @model.save()

  show_edit_form:->
    $(@el).html(@edit_task(@model.toJSON()))
    this

  del:(e)->
    e.preventDefault()
    @model.destroy()

  delete:->
    @.remove()
    
  render: ->
    $(@el).html(@template(@model.toJSON()))
    this
