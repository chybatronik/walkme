class WalkMe.Collections.Publications extends Backbone.Collection
  url: ->
    x = "/publications.json?auth_token=#{WalkMe.token}&url=#{document.location.href}"
    x

  model: WalkMe.Models.Publication

  delete_all:(options)->
    array = @toArray()
    for model in array
      model.destroy(options)

