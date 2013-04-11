console.log "page load"

load = =>
  style = document.createElement('link')
  style.rel = 'stylesheet'
  style.type = 'text/css'
  style.href = chrome.extension.getURL('fix.css')
  (document.head||document.documentElement).appendChild(style)


click = (e)=>
  e.preventDefault()
  console.log "click", e.target, $(e.target)[0].outerHTML;
  
  chrome.extension.sendMessage(
    action : "task"
    object:$(e.target)[0].outerHTML
  )
  
  

$("body").on("click",  click )
load()
console.log "page chrome.extension"

$.ready = =>  
  chrome.extension.onMessage.addListener((request,sender,sendResponse)=>
    console.log("page.coffee", request)
  )