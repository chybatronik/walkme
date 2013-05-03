class WalkMe.Collections.Catalogs extends Backbone.Collection
  localStorage: new Backbone.LocalStorage("App_Collections_Catalogs")  
  model: WalkMe.Models.Catalog

  delete_all:()->
    array = @toArray()
    for model in array
      model.destroy()

