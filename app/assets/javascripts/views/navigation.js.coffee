class WalkMe.Views.Navigate extends Backbone.View

  template: _.template(JST['navigate']())

  initialize:->
    _.bindAll @, "render"
    @.$el.append(@template(@model.toJSON()))

  render: ->
    tasks_veiw = new WalkMe.Views.TasksCollection(collection:@collection)
    @.$el.find(".main").append(tasks_veiw.render().el)
    @