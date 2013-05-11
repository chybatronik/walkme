describe "Publish", ->

  describe "Collection publication", ->
    publ = null

    beforeEach ->
      user = new WalkMe.Models.User({id: 1})
      user.fetch({async:false})
      console.log "USER", user
      user.set("email", "user@example.com")
      user.set("password", "changeme")
      user.save()
      user.generate_token()

      user.fetch({async:false})

      WalkMe.token = user.get("token")

      publ = new WalkMe.Collections.Publications()
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
      
