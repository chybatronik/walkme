App.Models.Task = Backbone.Model.extend(
)

App.Views.TaskView = Backbone.View.extend(
  manage: true
  template: '#task'
  tagName: "li"

  initialize:()->   
    _.bindAll @

  serialize: ->
    @model.toJSON()
)

App.Collections.TaskCollection = Backbone.Collection.extend(
  localStorage: new Backbone.LocalStorage("App_Collection_Task")
)

App.Views.TaskCollectionView = Backbone.View.extend(
  manage: true
  template: '#task-list'
  model: App.Models.Task

  initialize:()->   
    _.bindAll @

  beforeRender:->
  	@collection.each ((model) ->
      @insertView("ul", new App.Views.TaskView(
        model: new App.Models.Task(model)
      ))
    ), this

  serialize: ->
    @collection.toJSON()
)