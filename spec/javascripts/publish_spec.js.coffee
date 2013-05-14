login = =>
  WalkMe.Models.user = new WalkMe.Models.User({id: 1})
  WalkMe.Models.user.fetch({async:false})
  console.log "USER 1", WalkMe.Models.user
  WalkMe.Models.user.set("email", "user@example.com")
  WalkMe.Models.user.set("password", "changeme")
  WalkMe.Models.user.save()
  WalkMe.Models.user.generate_token()

  WalkMe.Models.user.fetch({async:false})

  WalkMe.token = WalkMe.Models.user.get("token")

  return WalkMe.Models.user


login_user2 = =>
  WalkMe.Models.user = new WalkMe.Models.User({id: 2})
  WalkMe.Models.user.fetch({async:false})
  console.log "USER 2", WalkMe.Models.user
  WalkMe.Models.user.set("email", "user2@example.com")
  WalkMe.Models.user.set("password", "changeme")
  WalkMe.Models.user.save()
  WalkMe.Models.user.generate_token()

  WalkMe.Models.user.fetch({async:false})

  WalkMe.token = WalkMe.Models.user.get("token") 

  return WalkMe.Models.user

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
      login_user2()
      model = new WalkMe.Models.Catalog()
      model.set("name", "name")
      model.save()

      catalogs = new WalkMe.Collections.Catalogs()
      catalogs.fetch({async:false})

      catalogs.at(0).make_public()
      login()
      publ.fetch({async:false})
      expect(publ.length).toBe(1)

  describe "View publication", ->

    publ = null

    beforeEach ->
      login()
      model = new WalkMe.Models.Catalog()
      model.set("name", "name")
      model.save()
      catalogs = new WalkMe.Collections.Catalogs()
      catalogs.fetch({async:false})
      console.log "catalogs", catalogs

      catalogs.at(0).make_public()

      login_user2()

      publ = new WalkMe.Collections.Publications()
      publ.fetch({async:false})    

    afterEach ->
      publ.fetch({async:false})
      publ.delete_all()

    it "render model", ->
      console.log "publ.at(0)", publ.at(0)
      view = new WalkMe.Views.Publication(
        model:publ.at(0)
        )
      view.render()
      console.log "view.el", view.el
      expect(view.el).not.toBe("")
      expect(view.render().$el.find("td:first").text()).toMatch /1/

  describe "View publication", ->

    publ = null
    user = null

    beforeEach ->
      user = login_user2()

      model = new WalkMe.Models.Catalog()
      model.set("name", "name")
      model.save()
      
      catalogs = new WalkMe.Collections.Catalogs()
      catalogs.fetch({async:false})

      console.log "catalogs", catalogs

      catalogs.at(0).make_public()


      user = login()
      publ = new WalkMe.Collections.Publications()
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