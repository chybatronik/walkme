class WalkMe.Views.Navigate extends Backbone.View

  template: _.template(JST['navigate']())

  events:
    "click td.span6": "choose_catalog"

  choose_catalog:(e)->
    console.log "choose_catalog", e.target.id 
    WalkMe.Collections.tasks = new WalkMe.Collections.Tasks(
      "catalog_id":e.target.id 
      )
    WalkMe.Collections.tasks.fetch({async:false})
    tasks_view = new WalkMe.Views.TasksCollection(collection:WalkMe.Collections.tasks)
    @.$el.find(".main").empty().append(tasks_view.render().el)

  initialize:->
    _.bindAll @, "render"
    @.$el.append(@template(@model.toJSON()))

  render: ->
    catalog_view = new WalkMe.Views.CatalogsCollection(collection:@collection)
    @.$el.find(".main").append(catalog_view.render().el)
    @