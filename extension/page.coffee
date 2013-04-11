console.log "page load"

click = (e)=>
  e.preventDefault()
  console.log "click", e.target, $(e.target)[0].outerHTML;
  
  chrome.extension.sendMessage(
    action : "task"
    object:$(e.target)[0].outerHTML
  )
  
  

$("body").on("click",  click )
