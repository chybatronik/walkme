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
      array = list_task.toArray()
      for model in array
        #console.log "each list_task", model
        model.destroy()
      
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
      expect(task_view.render().$el.find(".inline li:first").text()).toMatch /name/
      expect(task_view.render().$el.find(".inline li:eq(1)").text()).toMatch /text/

    it "change model", ->
      model.set("name", "qweqwe")
      expect(task_view.$el.find(".inline li:first").text()).toMatch /qweqwe/

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
      expect(tasks_view.$el.find(".inline:eq(0) li:first").text()).toMatch /000/
      expect(tasks_view.$el.find(".inline:eq(0) li:eq(1)").text()).toMatch /111/

  describe "View Navigate",  ->
    user = ""
    navig_view = ""

    beforeEach ->
      user = new WalkMe.Models.User({id: 1})
      collection = new WalkMe.Collections.Tasks()
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