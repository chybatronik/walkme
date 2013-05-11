class WalkMe.Models.Catalog extends Backbone.Model

  url: ->
    if @id
      x = "/catalogs/#{@.id}.json?auth_token=#{WalkMe.token}"
    else
      x = "/catalogs.json?auth_token=#{WalkMe.token}"
    x

  make_public:->
  	publ = new WalkMe.Collections.Publications()
  	publ.create(
  		url:@get("url")
  		user_id:@get("user_id")
  		catalog_id:@id
  		)