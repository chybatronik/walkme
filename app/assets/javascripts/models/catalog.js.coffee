class WalkMe.Models.Catalog extends Backbone.Model

  url: ->
      x = "/catalogs.json?auth_token=#{@token}"
      x