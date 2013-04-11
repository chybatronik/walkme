console.log "load background"

chrome.extension.onMessage.addListener((request,sender,sendResponse)=>
	console.log(request)
)
