class WalkMe.Collections.Tasks extends Backbone.Collection

	url: ->
    x = "/catalogs/#{WalkMe.current_catalog_id}/tasks.json?auth_token=#{WalkMe.token}"
    x
  #localStorage: new Backbone.LocalStorage("App_Collections_Tasks")  
  model: WalkMe.Models.Task

  delete_all:()->
    array = @toArray()
    for model in array
      model.destroy()

