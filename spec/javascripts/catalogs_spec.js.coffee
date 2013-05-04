# use require to load any .js file available to the asset pipeline

describe "Catalog", ->

  describe "Collections", ->

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

    afterEach ->
      catalogs.delete_all()

    it "init length right", ->
      expect(catalogs.length).toEqual(after_length)

    it "init length models right", ->
      expect(catalogs.models.length).toEqual(after_length)

    ###it "delete models at collection", ->
      catalogs.delete_all({wait:true})      
      catalogs.fetch({async:false})
      expect(catalogs.length).toEqual(0)###

  describe "View Collection",  ->

    catalogs_collection_view = ""
    collection = ""

    beforeEach ->
      collection = new WalkMe.Collections.Catalogs()
      collection.create(
        "name": "name"
        )
      collection.create(
        "name": "name1"
        )
      collection.create(
        "name": "name2"
        )

      catalogs_collection_view = new WalkMe.Views.CatalogsCollection(collection:collection)
      catalogs_collection_view.render()

    it "length catalog", ->
      console.log catalogs_collection_view.el
      expect(catalogs_collection_view.$el.find(".inline").length).toBe(3)

    it "add model in collection",  ->
      collection.create(
        "name": "name3"
        )
      expect(catalogs_collection_view.$el.find(".inline").length).toBe(3 + 1)

    it "refresh view change model",  ->
      model = collection.at(0)
      model.set("name", "000")
      expect(catalogs_collection_view.$el.find(".inline:eq(0) td:first").text()).toMatch /000/

  describe "View", ->
    task_view = ""
    model = ""

    beforeEach ->
      model = new WalkMe.Models.Catalog()
      model.set("name", "name")
      task_view = new WalkMe.Views.Catalog(model:model)
      task_view.render()

    it "render", ->
      expect(task_view.render().$el.find("td:first").text()).toMatch /name/

    it "change model", ->
      model.set("name", "qweqwe")
      expect(task_view.$el.find("td:first").text()).toMatch /qweqwe/

  describe "View Navigate",  ->
    user = null
    navig_view = null
    collection = null

    beforeEach ->
      user = new WalkMe.Models.User({id: 1})

      user.set("token", "token")
      user.set("email", "email@email.demo")
      user.save()
      collection = new WalkMe.Collections.Catalogs()
      collection.fetch({async:false})
      collection.delete_all()
      collection.create(
        "name": "name"
        )
      collection.create(
        "name": "name1"
        )

      navig_view = new WalkMe.Views.Navigate(
        model:user
        collection:collection
      )
      navig_view.render()

    it "render", ->
      expect(navig_view.el).not.toBeUndefined()

    it "render item",  ->
      expect(navig_view.$el.find(".inline:eq(0) td:first").text()).toMatch /name/
      expect(navig_view.$el.find(".inline:eq(1) td:first").text()).toMatch /name1/
      expect(navig_view.$el.find(".inline:eq(2)").length).toBe(0)

    it "render item after add", ->
      temp_collection = new WalkMe.Collections.Catalogs()
      temp_collection.create(
        "name": "name2"
        )
      collection.fetch({async:false})

      expect(navig_view.$el.find(".inline:eq(0) td:first").text()).toMatch /name/
      expect(navig_view.$el.find(".inline:eq(1) td:first").text()).toMatch /name1/
      expect(navig_view.$el.find(".inline:eq(2) td:first").text()).toMatch /name2/

    it "remove item after delete_all", ->
      collection.delete_all()
      expect(navig_view.$el.find(".inline").length).toBe(0)

  describe "View Navigate load view collection task",  ->
    user = null
    navig_view = null
    collection = null

    beforeEach ->
      user = new WalkMe.Models.User({id: 1})
      user.fetch({async:false})
      WalkMe.token = user.get("token")
      
      collection = new WalkMe.Collections.Catalogs()
      collection.fetch({async:false})
      collection.delete_all()
      collection.create(
        "name": "name"
        )
      collection.create(
        "name": "name1"
        )
      
      navig_view = new WalkMe.Views.Navigate(
        model:user
        collection:collection
      )
      navig_view.render()

    it "render list task in navigate", ->
      $("td:first").click()
      
