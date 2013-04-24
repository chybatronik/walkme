App.Views.NavigationView = Backbone.View.extend(
  manage: true
  template: '#navigation_view'

  initialize:(options)->   
    _.bindAll @
    @user = options.user

  events:
    "click #help": "help"
    "click #workspace": "workspace"
    "click #setting": "setting"
    "click #publish": "publish"
    "click #logout": "logout"

  help:(ev)->
    ev.preventDefault()

  workspace:(ev=null)->
    console.log "workspace"
    if ev?
      #ev.preventDefault()
      console.log "workspace", ev.target, $(ev.target).attr('id')

    task_collection = new App.Collections.TaskCollection()
    task_collection.fetch({async:false})
    console.log "task_collection", task_collection
    App.Views.mainLayout.setView(".content #workspace-panel .context",
        new App.Views.TaskCollectionView(collection:task_collection)
      ).render()

  afterRender:->
    $("#workspace")[0].click()

  setting:(ev)->
    console.log "setting", ev.target, $(ev.target).attr('id')

  publish:(ev)->
    console.log "publish", ev.target, $(ev.target).attr('id')

  logout:(ev)->
    console.log "logout", ev.target, $(ev.target).attr('id')
    App.Models.user.destroy()
    App.router.navigate('/app/demo', {trigger: true})

  serialize: ->
    @user.toJSON()
)
