class WalkMe.Views.Setting extends Backbone.View

  template: _.template(JST['setting']())

  events:
    "click #save": "save_color"

  initialize:->
    _.bindAll @, "render"

  render: ->
    @.$el.empty().append(@template(@model.toJSON()))
    @