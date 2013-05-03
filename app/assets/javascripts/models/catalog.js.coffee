class WalkMe.Models.Catalog extends Backbone.Model

  url: ->
    if @id
      x = "/catalogs/#{@.id}.json?auth_token=#{WalkMe.token}"
    else
      x = "/catalogs.json?auth_token=#{WalkMe.token}"
    x