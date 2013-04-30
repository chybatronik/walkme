# use require to load any .js file available to the asset pipeline

describe "DemoPage", ->

  describe "Collections Tasks", ->

    list_task = {}
    before_length = 0
    after_length = 0

    beforeEach ->
      list_task = new WalkMe.Collections.Tasks()
      list_task.fetch({async:false})
      before_length = list_task.length
      list_task.create({})
      list_task.create({})
      list_task.create({})
      list_task.create({})
      after_length = list_task.length

    it "init length right", ->
      expect(list_task.length).toEqual(after_length)

    it "init length models right", ->
      expect(list_task.models.length).toEqual(after_length)

    it "delete models at collection", ->
      list_task.delete_all()
      
      list_task.fetch({async:false})

      expect(list_task.length).toEqual(0)

  describe "View Task", ->
    task_view = ""
    model = ""

    beforeEach ->
      model = new WalkMe.Models.Task()
      model.set("name", "name")
      model.set("text", "text")
      task_view = new WalkMe.Views.Task(model:model)
      task_view.render()

    it "render", ->
      console.log task_view.render().el
      console.log task_view.render().$el.find("td:first")
      expect(task_view.render().$el.find("td:first").text()).toMatch /name/
      expect(task_view.render().$el.find("td:eq(1)").text()).toMatch /text/

    it "change model", ->
      model.set("name", "qweqwe")
      expect(task_view.$el.find("td:first").text()).toMatch /qweqwe/

  describe "TasksCollection",  ->

    tasks_view = ""
    collection = ""

    beforeEach ->
      collection = new WalkMe.Collections.Tasks()
      collection.create(
        "name": "name"
        "text": "text"
        )
      collection.create(
        "name": "name1"
        "text": "text1"
        )
      collection.create(
        "name": "name2"
        "text": "text2"
        )

      tasks_view = new WalkMe.Views.TasksCollection(collection:collection)
      tasks_view.render()

    it "length task", ->
      expect(tasks_view.$el.find(".inline").length).toBe(3)

    it "add model in collection",  ->
      collection.create(
        "name": "name3"
        "text": "text3"
        )
      expect(tasks_view.$el.find(".inline").length).toBe(3 + 1)

    it "refresh view change model",  ->
      model = collection.at(0)
      model.set("name", "000")
      model.set("text", "111")
      expect(tasks_view.$el.find(".inline:eq(0) td:first").text()).toMatch /000/
      expect(tasks_view.$el.find(".inline:eq(0) td:eq(1)").text()).toMatch /111/

  describe "View Navigate",  ->
    user = null
    navig_view = null
    collection = null

    beforeEach ->
      user = new WalkMe.Models.User({id: 1})
      collection = new WalkMe.Collections.Tasks()
      collection.fetch({async:false})
      collection.delete_all()
      collection.create(
        "name": "name"
        "text": "text"
        )
      collection.create(
        "name": "name1"
        "text": "text1"
        )
      user.fetch({async:false})
      navig_view = new WalkMe.Views.Navigate(
        model:user
        collection:collection
      )
      navig_view.render()

    it "render", ->
      expect(navig_view.el).not.toBeUndefined()

    it "render item",  ->
      expect(navig_view.$el.find(".inline:eq(0) td:first").text()).toMatch /name/
      expect(navig_view.$el.find(".inline:eq(0) td:eq(1)").text()).toMatch /text/
      expect(navig_view.$el.find(".inline:eq(1) td:first").text()).toMatch /name1/
      expect(navig_view.$el.find(".inline:eq(1) td:eq(1)").text()).toMatch /text1/
      expect(navig_view.$el.find(".inline:eq(2)").length).toBe(0)

    it "render item after add", ->
      temp_collection = new WalkMe.Collections.Tasks()
      temp_collection.create(
        "name": "name2"
        "text": "text2"
        )
      collection.fetch({async:false})

      expect(navig_view.$el.find(".inline:eq(0) td:first").text()).toMatch /name/
      expect(navig_view.$el.find(".inline:eq(0) td:eq(1)").text()).toMatch /text/
      expect(navig_view.$el.find(".inline:eq(1) td:first").text()).toMatch /name1/
      expect(navig_view.$el.find(".inline:eq(1) td:eq(1)").text()).toMatch /text1/
      expect(navig_view.$el.find(".inline:eq(2) td:first").text()).toMatch /name2/
      expect(navig_view.$el.find(".inline:eq(2) td:eq(1)").text()).toMatch /text2/

    it "remove item after delete_all", ->
      collection.delete_all()
      expect(navig_view.$el.find(".inline").length).toBe(0)

