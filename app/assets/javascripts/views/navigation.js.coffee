class WalkMe.Views.Navigate extends Backbone.View

  template: _.template(JST['navigate']())

  events:
  	"click td": "cli"

  cli:->
  	console.log "CLI"

  initialize:->
    _.bindAll @, "render"
    @.$el.append(@template(@model.toJSON()))

  render: ->
    catalog_view = new WalkMe.Views.CatalogsCollection(collection:@collection)
    @.$el.find(".main").append(catalog_view.render().el)
    @