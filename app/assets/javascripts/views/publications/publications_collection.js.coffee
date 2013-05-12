class WalkMe.Views.PublicationsCollection extends Backbone.View

  template: JST['publications/collection']

  initialize: ->
    _.bindAll @
    @collection.on('reset', @render, this)
    @collection.on('add', @addOnePublication, this)
    @.$el.append(@template())

  render: ->
    @collection.each(@addOnePublication, @)   
    @

  addOnePublication:(model)->
    console.log "PPP", model.get("user_id"), WalkMe.Models.user.get("user_id")
    if model.get("user_id") != WalkMe.Models.user.get("user_id") 
      pub_vew = new WalkMe.Views.Publication(model:model)
      @.$el.find(".main").append(pub_vew.render().el)

    