class WalkMe.Views.Navigate extends Backbone.View

  template: _.template(JST['navigate']())

  initialize:->
    _.bindAll @
    @.$el.append(@template(@model.toJSON()))

  render: ->
    collection = new WalkMe.Collections.Tasks()
    collection.fetch({async:false})

    tasks_veiw = new WalkMe.Views.TasksCollection(collection:collection)
    @.$el.find(".main").append(tasks_veiw.render().el)
    @