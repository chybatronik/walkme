class WalkMe.Views.Navigate extends Backbone.View

  template: _.template(JST['navigate']())

  events:
    "click td.span6": "choose_catalog"
    "click #back": "render"
    "click #help": "help"
    "click #logout": "logout"
    "click #setting": "setting"
    "click #publish": "publish"

  help:(e)->
    e.preventDefault()
    a = "#help"
    console.log "HELP", $("#help[data-content]").length
    if $("#help[data-content]").length == 0      
      name = ""
      text = """<ol>
        <li><a>Link 1</a></li>
        <li><a>Link 2</a></li>
        <li><a>Link 3</a></li>
        <li><a>Link 4</a></li>
      </ol>
      """
      $(a).attr('data-original-title', name)
      $(a).attr('data-placement', "bottom")
      $(a).attr('data-content', text)
      $(a).attr('data-html', "true")
      $(a).popover('show')
    else
      $(a).removeAttr('data-content')
      $(a).removeAttr('data-placement')
      $(a).removeAttr('data-original-title')
      $(".popover").remove()

  logout:(e)->
    e.preventDefault()
    console.log "logout"
    WalkMe.Models.user.destroy()
    WalkMe.Routers.app.navigate('/app/demo/login', {trigger: true})

  setting:(e)->
    e.preventDefault()
    console.log "setting"

  publish:(e)->
    e.preventDefault()
    console.log "publish"
    
  choose_catalog:(e)->
    console.log "choose_catalog", e.target.id 
    WalkMe.current_catalog_id = e.target.id
    WalkMe.Collections.tasks = new WalkMe.Collections.Tasks( )
    WalkMe.Collections.tasks.fetch({async:false})
    tasks_view = new WalkMe.Views.TasksCollection(collection:WalkMe.Collections.tasks)
    @.$el.find(".main_list_task").empty().append(tasks_view.render().el)
    @.$el.find(".main_list_task").removeClass("hide")
    @.$el.find(".main_list_categor").addClass("hide")

  initialize:->
    _.bindAll @, "render"
    @.$el.append(@template(@model.toJSON()))

  render: ->
    catalog_view = new WalkMe.Views.CatalogsCollection(collection:@collection)
    @.$el.find(".main_list_categor").empty().append(catalog_view.render().el)
    @.$el.find(".main_list_categor").removeClass("hide")
    @.$el.find(".main_list_task").addClass("hide")
    @