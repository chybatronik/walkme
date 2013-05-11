describe "Publish", ->

  describe "Collection publication", ->
    publ = null

    beforeEach ->
      publ = new WalkMe.Collections.Publications()
      publ.fetch({async:false})
      publ.delete_all()

    it "defined", ->
      expect(publ.length).toBe(0)

    it "create publication catalog", ->
      catalogs = new WalkMe.Collections.Catalogs()
      catalogs.fetch({async:false})
      
