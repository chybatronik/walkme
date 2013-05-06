class WalkMe.Views.Navigate extends Backbone.View

  template: _.template(JST['navigate']())

  events:
    "click td.span6": "choose_catalog"
    "click #back": "render"

  choose_catalog:(e)->
    console.log "choose_catalog", e.target.id 
    WalkMe.current_catalog_id = e.target.id
    WalkMe.Collections.tasks = new WalkMe.Collections.Tasks( )
    WalkMe.Collections.tasks.fetch({async:false})
    tasks_view = new WalkMe.Views.TasksCollection(collection:WalkMe.Collections.tasks)
    @.$el.find(".main_list_task").empty().append(tasks_view.render().el)
    @.$el.find(".main_list_task").removeClass("hide")
    @.$el.find(".main_list_categor").addClass("hide")

  initialize:->
    _.bindAll @, "render"
    @.$el.append(@template(@model.toJSON()))

  render: ->
    catalog_view = new WalkMe.Views.CatalogsCollection(collection:@collection)
    @.$el.find(".main_list_categor").empty().append(catalog_view.render().el)
    @.$el.find(".main_list_categor").removeClass("hide")
    @.$el.find(".main_list_task").addClass("hide")
    @