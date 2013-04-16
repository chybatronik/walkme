NavigationView = Backbone.View.extend(
  template: '#navigation_view'

  initialize:(options)->   
    _.bindAll @
    @user = options.user
    console.log "initialize NavigationView", @user.get("email")

  events:
    "click #help": "help"
    "click #workspace": "workspace"
    "click #setting": "setting"
    "click #publish": "publish"
    "click #logout": "logout"
    "click #start": "start"
    "click #stop": "stop"
    "click #play": "play"
    "click #clear_data": "clear_data"

  start:(ev)->
    ev.preventDefault()
    send_content_script("start")

  stop:(ev)->
    ev.preventDefault()
    send_content_script("stop")

  play:(ev)->
    ev.preventDefault()
    # chrome.storage.sync.get('tasks', (storage)=>
    #   console.log "get tasks", storage
    #   stored = JSON.parse(storage.tasks)
    #   console.log "get length", stored.length
    #   send_content_script("play", storage.tasks)
    # )
  
  clear_data:(ev)->
    ev.preventDefault()
    ###chrome.storage.sync.set({'tasks': JSON.stringify([])}, =>
      console.log('clear_data')
      @.render()
    )###

  help:(ev)->
    ev.preventDefault()

  workspace:(ev)->
    console.log "workspace", ev.target, $(ev.target).attr('id')

  setting:(ev)->
    console.log "setting", ev.target, $(ev.target).attr('id')

  publish:(ev)->
    console.log "publish", ev.target, $(ev.target).attr('id')

  logout:(ev)->
    console.log "logout", ev.target, $(ev.target).attr('id')
    @user.delete()
    $('.navigation').empty()
    login()

  ###render:->
    chrome.storage.sync.get('tasks', (storage)=>
      console.log "get tasks", storage
      if storage.tasks?
        stored = JSON.parse(storage.tasks)
        console.log "get length", stored.length
      else
        stored = []
      this.$el.html(this.template({name: user.email, tasks:stored}));
      $('.navigation').empty().append(this.el)
    )###
  serialize: ->
    @collection.toJSON()
)

send_content_script = (action, stored=null) =>
  ###chrome.tabs.query({"status":"complete","windowId":chrome.windows.WINDOW_ID_CURRENT,"active":true}, 
    (tabs)=>
      console.log(JSON.stringify(tabs[0]))
      console.log(tabs[0].id)
      if stored
        chrome.tabs.sendMessage(tabs[0].id, {action : action, stored: stored }) 
      else
        chrome.tabs.sendMessage(tabs[0].id, {action : action}) 
  )###