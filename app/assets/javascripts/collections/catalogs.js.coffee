class WalkMe.Collections.Catalogs extends Backbone.Collection
  url: ->
    x = "/catalogs.json?auth_token=#{WalkMe.token}&url=#{document.location.href}"
    x
  #localStorage: new Backbone.LocalStorage("App_Collections_Catalogs")  
  model: WalkMe.Models.Catalog

  delete_all:(options)->
    array = @toArray()
    for model in array
      model.destroy(options)

