( ($) ->

  console.log "page load"
  current_element = ""
  count_task = 0
  is_show_modal = false


  load_style_popup_wiget = =>
    styleNode = document.createElement('style')
    styleNode.type = "text/css"
    user = WalkMe.Models.user
    user.fetch({async:false})
    text = ".introjs-tooltip { background-color: #{user.get("ballon")}; }"
    text += ".introjs-tooltiptext { background-color: #{user.get("header")}; }"
    text += ".introjs-tooltiptext { background-color: #{user.get("content")}; }"
    #text += ".introjs-button { background-color: #{user.get("button")}; }"
    text += ".introjs-button { background-image: -webkit-gradient(linear,0 0,0 100%,from(#f4f4f4),to(#{user.get("button")})); }"
    text += ".introjs-button { color: #{user.get("button_text")}; }"

    if styleNode.styleSheet
      styleNode.styleSheet.cssText = text
    else 
      styleNode.innerText = text
    
    (document.head||document.documentElement).appendChild(styleNode);

  load_one_style = (name_file)=>
    elem = document.getElementById(name_file)
    if not elem
      style = document.createElement('link')
      style.rel = 'stylesheet'
      style.id =  name_file
      style.type = 'text/css'
      style.href = "/demo/" + name_file
      (document.head||document.documentElement).appendChild(style)

  load_one_script = (name_file)=>
    elem = document.getElementById(name_file)
    if not elem
      D           = document
      scriptNode  = D.createElement ('script')
      scriptNode.type = "text/javascript"
      scriptNode.src  = "/demo/" + name_file
      scriptNode.id = name_file
      targ = D.getElementsByTagName('head')[0] || D.body || D.documentElement
      targ.appendChild (scriptNode)

  loads = =>
    load_one_style("fix.css")
    #load_one_script("lib/intro/intro.min.js")
    #load_one_style("lib/intro/introjs-ie.min.css")
    #load_one_style("lib/intro/introjs.min.css")
    #load_one_script("lib/bootstrap/js/bootstrap.js")
    load_one_style("lib/bootstrap/css/bootstrap.min.css")
    load_one_style("lib/bootstrap/css/bootstrap-responsive.min.css")
    elem = $("#myModal")
    if elem.length == 0
      $('body').append(form_create)


  remove_one = (id)=>
    elem = document.getElementById(id)
    if elem
      elem.parentNode.removeChild(elem)

  removes = =>
    remove_one("fix.css")
    #remove_one("lib/intro/intro.min.js")
    #remove_one("lib/intro/introjs-ie.min.css")
    #remove_one("lib/intro/introjs.min.css")
    remove_one("lib/bootstrap/css/bootstrap.min.css")
    remove_one("lib/bootstrap/css/bootstrap-responsive.min.css")

  save_task = (action, name, text, current_element)=>
    console.log "save_task", action, name, text, current_element
    ###task = new App.Models.Task()
    task.set(
      action : "task"
      name  : name
      text  : text
      object: current_element
        )###
    list_task = new WalkMe.Collections.Tasks()
    list_task.fetch({async:false})
    list_task.create(
      action : action
      name  : name
      text  : text
      object: current_element
      )
    console.log "list_task", list_task
    
  get_task = =>
    list_task = new WalkMe.Collections.Tasks()
    list_task.fetch({async:false})
    list_task

  click = (e)=>
    e.preventDefault()
    console.log "CLICK", $(e.target)[0].id
    if $(e.target)[0].id == "button_walkme"
      console.log "button_walkme"
      $("body").off("click",  click )
      removes()
      return 
    if $(e.target)[0].id == "save_send_data"

      name = $("#inputName").val()
      text = $("#inputText").val()
      a = current_element
      $(a).attr('data-intro', name + " -- " + text)
      $(a).attr('data-step', count_task)
      $(a).attr('data-original-title', name)
      $(a).attr('data-placement', "top")
      $(a).attr('data-content', text)
      $(a).popover('show')

      save_task("task", name, text, a)
      ###chrome.extension.sendMessage(
        action : "task"
        name  : name
        text  : text
        object: current_element
      )###

      load_one_style("fix.css")
      $('#myModal').modal('hide')
      is_show_modal = false
    else
      if not is_show_modal
        count_task += 1

        remove_one("fix.css")
        current_element = $(e.target).getPath()
        $('#myModal').modal('show')
        is_show_modal = true

    if $(e.target)[0].id == "close_data"
      load_one_style("fix.css")
      $('#myModal').modal('hide')
      is_show_modal = false


  WalkMe.Actions.start = =>
    $("body").on("click",  click )
    loads()
    $('#myModal').on('hidden', ->
      is_show_modal = false
      load_one_style("fix.css")
    )
    $('#myModal').on('show', ->
      remove_one("fix.css")
    )
    console.log "page chrome.extension start"

  WalkMe.Actions.stop = =>
    $("body").off("click",  click )
    removes()
    console.log "page chrome.extension stop"

  WalkMe.Actions.play = =>
    $("body").off("click",  click )
    removes()
    #load_one_script("lib/intro/intro.min.js")
    load_style_popup_wiget()

    load_one_style("lib/intro/introjs-ie.min.css")
    load_one_style("lib/intro/introjs.min.css")
    $(".popover").remove();
    $("*").removeAttr("data-step")
    $("*").removeAttr("data-intro")
    #console.log "page chrome.extension play", request.stored
    stored = get_task()
    console.log "stored", stored
    count = 0 
    for elem in stored.models
      count += 1
      console.log "elem", elem
      a = elem.get("object")
      console.log "a", a
      $(a).attr('data-intro', elem.get("name") + " -- " + elem.get("text"))
      $(a).attr('data-step', count)
      
    introJs().start()
    console.log "action play"

  form_create =  """
      <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width: 360px;top: 25%;">
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
  
) jQuery