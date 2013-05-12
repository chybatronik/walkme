class WalkMe.Views.Publication extends Backbone.View

  template: _.template(JST['publications/publication']())
  tagName :"tr"
  className:"inline"

  events:
    "click .add_public": "add_public"

  initialize:->
    _.bindAll @
    @model.on("change", @render, @)
    @model.on("remove", @delete, @)

  delete:->
    @.remove()
  
  add_public:(e)->
    e.preventDefault()
    console.log 
    catalog = new WalkMe.Models.Catalog(id:@model.get("catalog_id"))
    catalog.fetch({async:false})
    
    catalogs = new WalkMe.Collections.Catalogs()
    catalogs.fetch({async:false})

    catalogs.add(catalog)

  render: ->
    name_catalog = new WalkMe.Models.Catalog(id:@model.get("catalog_id"))
    name_catalog.fetch({async:false})

    $(@el).html(@template(
      user_id:@model.get("user_id")
      catalog_id:name_catalog.get("name")
      ))
    this
