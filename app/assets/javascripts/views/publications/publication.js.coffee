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
    
    catalog_public = new WalkMe.Models.Catalog(id:@model.get("catalog_id"))
    catalog_public.fetch({async:false})

    WalkMe.current_catalog_id = @model.get("catalog_id")

    tasks_public = new WalkMe.Collections.Tasks( )
    tasks_public.fetch({async:false})
    
    console.log "tasks_public", tasks_public

    console.log '@model.get("catalog_id")', @model.get("catalog_id")

    new_catalog = new WalkMe.Models.Catalog()
    new_catalog.set(
      "name": catalog_public.get("name")
      "url": catalog_public.get("url")
      )

    new_catalog.save({wait: true}).success ->
      console.log "END", new_catalog.get("id")
      console.log "new_catalog", new_catalog, new_catalog.id, new_catalog.get("user_id")

      WalkMe.current_catalog_id = new_catalog.id

      tasks_public.each((model)=>
        console.log "model", model
        task = new WalkMe.Models.Task()
        task.set(
          "name": model.get("name")
          "text": model.get("text")
          "object:": model.get("object")
          "url:": model.get("url")
          )
        task.save()
        )
      WalkMe.Collections.catalogs.fetch({async:false})

  render: ->
    name_catalog = new WalkMe.Models.Catalog(id:@model.get("catalog_id"))
    name_catalog.fetch({async:false})

    $(@el).html(@template(
      user_id:@model.get("user_id")
      catalog_id:name_catalog.get("name")
      ))
    this
