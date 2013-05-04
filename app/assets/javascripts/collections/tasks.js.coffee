class WalkMe.Collections.Tasks extends Backbone.Collection

	initialize:(options)->
		console.log "@catalog_id", options.catalog_id
		@catalog_id = options.catalog_id

	url: ->
    x = "/tasks.json?auth_token=#{WalkMe.token}&catalog_id=#{@catalog_id}"
    x
  #localStorage: new Backbone.LocalStorage("App_Collections_Tasks")  
  model: WalkMe.Models.Task

  delete_all:()->
    array = @toArray()
    for model in array
      model.destroy()

