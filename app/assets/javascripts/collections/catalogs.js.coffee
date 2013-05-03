class WalkMe.Collections.Catalogs extends Backbone.Collection
  url: ->
    x = "/catalogs.json?auth_token=#{@token}"
    x
  #localStorage: new Backbone.LocalStorage("App_Collections_Catalogs")  
  model: WalkMe.Models.Catalog

  initialize: (options) ->
    console.log options
    @token = options.token

  delete_all:()->
    array = @toArray()
    for model in array
      model.destroy()

