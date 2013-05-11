class WalkMe.Models.Publication extends Backbone.Model

  url: ->
    if @id
      x = "/publications/#{@.id}.json?auth_token=#{WalkMe.token}"
    else
      x = "/publications.json?auth_token=#{WalkMe.token}"
    x