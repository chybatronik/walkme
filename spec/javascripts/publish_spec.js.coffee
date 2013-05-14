login = =>
  user = new WalkMe.Models.User({id: 1})
  user.fetch({async:false})
  console.log "USER", user
  user.set("email", "user@example.com")
  user.set("password", "changeme")
  user.save()
  user.generate_token()

  user.fetch({async:false})

  WalkMe.token = user.get("token")
  WalkMe.Models.user = user

describe "Publish", ->

  describe "Collection publication", ->
    publ = null

    beforeEach ->
      login()

      publ = new WalkMe.Collections.Publications()
      publ.fetch({async:false})
      publ.delete_all()

    afterEach ->
      publ.fetch({async:false})
      publ.delete_all()

    it "defined", ->
      expect(publ.length).toBe(0)

    it "create publication catalog", ->
      catalogs = new WalkMe.Collections.Catalogs()
      catalogs.fetch({async:false})

      catalogs.at(0).make_public()
      publ.fetch({async:false})
      expect(publ.length).toBe(1)

  describe "View publication", ->

    publ = null

    beforeEach ->

      login()

      publ = new WalkMe.Collections.Publications()
      publ.fetch({async:false})
      publ.delete_all()
      
      catalogs = new WalkMe.Collections.Catalogs()
      catalogs.fetch({async:false})

      catalogs.at(0).make_public()
      publ.fetch({async:false})

    afterEach ->
      publ.fetch({async:false})
      publ.delete_all()

    it "render model", ->
      view = new WalkMe.Views.Publication(
        model:publ.at(0)
        )
      view.render()
      console.log "view.el", view.el
      expect(view.el).not.toBe("")
      expect(view.render().$el.find("td:first").text()).toMatch /1/

  describe "View publication", ->

    publ = null

    beforeEach ->
      login()

      publ = new WalkMe.Collections.Publications()
      publ.fetch({async:false})
      publ.delete_all()
      
      catalogs = new WalkMe.Collections.Catalogs()
      catalogs.fetch({async:false})

      console.log "catalogs", catalogs

      catalogs.at(0).make_public()
      publ.fetch({async:false})

    afterEach ->
      publ.fetch({async:false})
      publ.delete_all()

    it "render Collection", ->
      view = new WalkMe.Views.PublicationsCollection(
        collection:publ
        )
      view.render()
      console.log "view.el", view.el
      expect(view.el).not.toBe("")
      expect(view.$el.find(".inline").length).toBe(1)