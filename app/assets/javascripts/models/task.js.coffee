class WalkMe.Models.Task extends Backbone.Model

	url: ->
    if @id
      x = "/tasks/#{@.id}.json?auth_token=#{WalkMe.token}"
    else
      x = "/tasks.json?auth_token=#{WalkMe.token}"
    x
