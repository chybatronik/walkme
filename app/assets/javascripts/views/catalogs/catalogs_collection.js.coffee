class WalkMe.Views.CatalogsCollection extends Backbone.View

  template: JST['catalogs/collection']

  events:
    "click #clear_data": "clear_data"

  initialize: ->
    _.bindAll @
    @collection.on('reset', @render, this)
    @collection.on('add', @addOneCatalog, this)
    @.$el.append(@template())
    
  clear_data:(e)->
    e.preventDefault()
    e.stopPropagation()
    #send_content_script("clear")
    @collection.delete_all()

  render: ->
    #@.$el.append(@template())
    @collection.each(@addOneCatalog, @)   
    @

  addOneCatalog:(model)->
    catalog_vew = new WalkMe.Views.Catalog(model:model)
    @.$el.find(".main").append(catalog_vew.render().el)

    