# use require to load any .js file available to the asset pipeline

describe "Catalog", ->

  describe "Collections Catalogs", ->

    catalogs = null
    before_length = null
    after_length = null

    beforeEach ->
      catalogs = new WalkMe.Collections.Catalogs()
      catalogs.fetch({async:false})
      before_length = catalogs.length
      catalogs.create({})
      catalogs.create({})
      catalogs.create({})
      catalogs.create({})
      after_length = catalogs.length

    it "init length right", ->
      expect(catalogs.length).toEqual(after_length)

    it "init length models right", ->
      expect(catalogs.models.length).toEqual(after_length)

    it "delete models at collection", ->
      catalogs.delete_all()
      
      catalogs.fetch({async:false})

      expect(catalogs.length).toEqual(0)

