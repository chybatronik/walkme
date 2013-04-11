console.log "page load"
current_element = ""
count_task = 0

load_one_style = (name_file)=>
  style = document.createElement('link')
  style.rel = 'stylesheet'
  style.id = name_file
  style.type = 'text/css'
  style.href = chrome.extension.getURL(name_file)
  (document.head||document.documentElement).appendChild(style)

load_one_script = (name_file)=>
  D           = document
  scriptNode  = D.createElement ('script')
  scriptNode.type = "text/javascript"
  scriptNode.src  = chrome.extension.getURL (name_file)
  scriptNode.id = name_file
  targ = D.getElementsByTagName('head')[0] || D.body || D.documentElement
  targ.appendChild (scriptNode)

loads = =>
  load_one_style("fix.css")
  load_one_script("lib/intro/intro.min.js")
  load_one_style("lib/intro/introjs-ie.min.css")
  load_one_style("lib/intro/introjs.min.css")
  load_one_script("lib/bootstrap/js/bootstrap.js")
  load_one_style("lib/bootstrap/css/bootstrap.min.css")
  load_one_style("lib/bootstrap/css/bootstrap-responsive.min.css")
  $('body').append(form_create)


remove_one = (id)=>
  elem = document.getElementById(id)
  elem.parentNode.removeChild(elem)

removes = =>
  remove_one("fix.css")
  remove_one("lib/intro/intro.min.js")
  remove_one("lib/intro/introjs-ie.min.css")
  remove_one("lib/intro/introjs.min.css")

click = (e)=>
  e.preventDefault()
  if $(e.target)[0].id == "save_send_data"
    console.log "save_send_data"
    #load_one_style("fix.css")
    console.log  $('#myModal').modal('show')
  else
    count_task += 1
    console.log "click", $(e.target)[0].id, $(e.target)[0].outerHTML;
    #remove_one("fix.css")
    console.log $("*").find('#myModal').modal('show')#$('#myModal').modal('show')
  ##clear
  #$("body").off("click",  click )
  #remove_one("fix.css")
  ##important data
  current_element = $(e.target)[0].outerHTML

  ###chrome.extension.sendMessage(
    action : "task"
    object:$(e.target)[0].outerHTML
  )###




$.ready = =>  
  ###$("#save_send_data").live("click",  save_send_data )###
  chrome.extension.onMessage.addListener((request,sender,sendResponse)=>
    console.log("page.coffee", request.action)
    switch request.action
      when "start"
        $("body").on("click",  click )
        loads()
        console.log "page chrome.extension start"
      when "stop" 
        $("body").off("click",  click )
        removes()
        console.log "page chrome.extension stop"
  )

form_create =  """
    <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width: 360px;top: 50%;">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
              <h3 id="myModalLabel">Modal Heading</h3>
            </div>
            <div class="modal-body">
              <div class="control-group">
                <label class="control-label" for="inputEmail">Name</label>
                <div class="controls">
                  <input type="text" id="inputName" placeholder="Name">
                </div>
              </div>
              <div class="control-group">
                <label class="control-label" for="inputText">Description</label>
                <div class="controls">
                  <textarea rows="3" id="inputText"></textarea>
                </div>
              </div>
              
            </div>
            <div class="modal-footer">
              <button class="btn" data-dismiss="modal">Close</button>
              <button class="btn btn-primary" id="save_send_data">Save changes</button>
            </div>
          </div>
        """