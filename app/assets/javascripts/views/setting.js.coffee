class WalkMe.Views.Setting extends Backbone.View

  template: _.template(JST['setting']())

  events:
    "click #save": "save_color"
    "click #defaults": "defaults"

  save_color:(e)->
    e.preventDefault()
    console.log "Save"
    WalkMe.Models.user.set("ballon",  @$el.find("#ballon").val())
    WalkMe.Models.user.set("header", @$el.find("#header").val())
    WalkMe.Models.user.set("content", @$el.find("#content").val())
    WalkMe.Models.user.set("button", @$el.find("#button").val())
    WalkMe.Models.user.set("button_text", @$el.find("#button_text").val())
    WalkMe.Models.user.save()
    console.log WalkMe.Models.user

  defaults:(e)->
    e.preventDefault()
    console.log "@model.defaults", @model.defaults
    @model.set(@model.defaults)
    @model.save()
    @.render()
    console.log "@model", @model

  initialize:->
    _.bindAll @, "render"
    @model.on("change", @render, @)

  render: ->
    console.log "render @model", @model
    @.$el.empty().append(@template(@model.toJSON()))
    @.$el.find('.color').colorpicker()
    @