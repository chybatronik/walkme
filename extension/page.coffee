console.log "page load"

click = (e)=>
  e.preventDefault()
  console.log "click", e.target, $(e.target);

$("body").on("click",  click )


`
chrome.extension.onRequest.addListener(function(request, sender, sendResponse) {
  if (request.method == "fromPopup") {
    // Send JSON data back to Popup.
    sendResponse({data: "from Content Script to Popup"});

    // Send JSON data to background page.
    chrome.extension.sendRequest({method: "fromContentScript"}, function(response) {
      console.log(response.data);
    });
  } else {
    sendResponse({}); // snub them.
  }
});
`