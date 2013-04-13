console.log "load background"
stored = []

chrome.storage.sync.get('tasks', (storage)=>
  console.log "get tasks", storage
  if 'tasks' in storage
    stored = JSON.parse(storage.tasks)
    console.log "get length", stored.length
)

chrome.extension.onMessage.addListener((request,sender,sendResponse)=>
  console.log(request, JSON.stringify(request))
  if request.action == "task"
    chrome.storage.sync.get('tasks', (storage)=>
      console.log "get tasks", storage
      if 'tasks' in storage
        stored = JSON.parse(storage.tasks)
        console.log "get length", stored.length
      stored.push(request)
      console.log JSON.stringify(stored)
      chrome.storage.sync.set({'tasks': JSON.stringify(stored)}, =>
        console.log('Settings saved')
      )
    )
    
)
