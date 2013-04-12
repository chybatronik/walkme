`
jQuery.fn.getPath = function () {
    if (this.length != 1) throw 'Requires one element.';

    var path, node = this;
    while (node.length) {
        var realNode = node[0], name = realNode.localName;
        if (!name) break;
        name = name.toLowerCase();

        var parent = node.parent();

        var siblings = parent.children(name);
        if (siblings.length > 1) { 
            name += ':eq(' + siblings.index(realNode) + ')';
        }

        path = name + (path ? '>' + path : '');
        node = parent;
    }

    return path;
};
`

console.log "page load"
current_element = ""
count_task = 0
is_show_modal = false

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
  #load_one_script("lib/intro/intro.min.js")
  load_one_style("lib/intro/introjs-ie.min.css")
  load_one_style("lib/intro/introjs.min.css")
  #load_one_script("lib/bootstrap/js/bootstrap.js")
  load_one_style("lib/bootstrap/css/bootstrap.min.css")
  load_one_style("lib/bootstrap/css/bootstrap-responsive.min.css")
  $('body').append(form_create)


remove_one = (id)=>
  elem = document.getElementById(id)
  elem.parentNode.removeChild(elem)

removes = =>
  remove_one("fix.css")
  #remove_one("lib/intro/intro.min.js")
  remove_one("lib/intro/introjs-ie.min.css")
  remove_one("lib/intro/introjs.min.css")


click = (e)=>
  e.preventDefault()
  if $(e.target)[0].id == "save_send_data"
    console.log "save_send_data"
    

    name = $("#inputName").val()
    text = $("#inputText").val()
    a = current_element
    $(a).attr('data-intro', name + " -- " + text)
    $(a).attr('data-step', count_task)
    $(a).attr('data-original-title', name)
    $(a).attr('data-placement', "top")
    $(a).attr('data-content', text)
    $(a).popover('show')

    console.log $(a).attr('data-intro'), $(a).attr('data-step')
    #introJs().start();
    chrome.extension.sendMessage(
      action : "task"
      name  : name
      text  : text
      object: current_element
    )

    load_one_style("fix.css")
    $('#myModal').modal('hide')
    is_show_modal = false
  else
    if not is_show_modal
      count_task += 1
      console.log "click", $(e.target).getPath(), $(e.target)[0].outerHTML;

      remove_one("fix.css")
      current_element = $(e.target).getPath()
      $('#myModal').modal('show')
      is_show_modal = true

  if $(e.target)[0].id == "close_data"
    load_one_style("fix.css")
    $('#myModal').modal('hide')
    is_show_modal = false

$.ready = =>  
  console.log "main"
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
              <button class="btn" data-dismiss="modal" id="close_data">Close</button>
              <button class="btn btn-primary" id="save_send_data">Save changes</button>
            </div>
          </div>
        """