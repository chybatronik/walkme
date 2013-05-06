class WalkMe.Models.Task extends Backbone.Model

	url: ->
    if @id
      x = "/catalogs/#{WalkMe.current_catalog_id}/tasks/#{@.id}.json?auth_token=#{WalkMe.token}"
    else
      x = "/catalogs/#{WalkMe.current_catalog_id}/tasks.json?auth_token=#{WalkMe.token}"
    x
