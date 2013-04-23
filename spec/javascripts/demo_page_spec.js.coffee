# use require to load any .js file available to the asset pipeline
#= require application

describe "DemoPage", ->
  list_task = {}
  before_length = 0
  after_length = 0

  beforeEach ->
    list_task = new App.Collections.TaskCollection()
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
      console.log "each list_task", model
      model.destroy()
    
    list_task.fetch({async:false})

    expect(list_task.length).toEqual(0)
