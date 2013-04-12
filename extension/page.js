// Generated by CoffeeScript 1.6.2
(function() {
  var click, count_task, current_element, form_create, get_element, is_show_modal, load_one_script, load_one_style, loads, remove_one, removes,
    _this = this;

  console.log("page load");

  current_element = "";

  count_task = 0;

  is_show_modal = false;

  load_one_style = function(name_file) {
    var style;

    style = document.createElement('link');
    style.rel = 'stylesheet';
    style.id = name_file;
    style.type = 'text/css';
    style.href = chrome.extension.getURL(name_file);
    return (document.head || document.documentElement).appendChild(style);
  };

  load_one_script = function(name_file) {
    var D, scriptNode, targ;

    D = document;
    scriptNode = D.createElement('script');
    scriptNode.type = "text/javascript";
    scriptNode.src = chrome.extension.getURL(name_file);
    scriptNode.id = name_file;
    targ = D.getElementsByTagName('head')[0] || D.body || D.documentElement;
    return targ.appendChild(scriptNode);
  };

  loads = function() {
    load_one_style("fix.css");
    load_one_style("lib/intro/introjs-ie.min.css");
    load_one_style("lib/intro/introjs.min.css");
    load_one_style("lib/bootstrap/css/bootstrap.min.css");
    load_one_style("lib/bootstrap/css/bootstrap-responsive.min.css");
    return $('body').append(form_create);
  };

  remove_one = function(id) {
    var elem;

    elem = document.getElementById(id);
    return elem.parentNode.removeChild(elem);
  };

  removes = function() {
    remove_one("fix.css");
    remove_one("lib/intro/introjs-ie.min.css");
    return remove_one("lib/intro/introjs.min.css");
  };

  get_element = function(elem) {
    var query;

    query = elem.replace("'", "\'");
    query = "'*:contains(\"" + elem + "\")'";
    console.log(query);
    return query;
  };

  click = function(e) {
    var a, name, text;

    e.preventDefault();
    if ($(e.target)[0].id === "save_send_data") {
      console.log("save_send_data");
      name = $("#inputName").val();
      text = $("#inputText").val();
      a = get_element(current_element);
      $(a).attr('data-intro', name + " -- " + text);
      $(a).attr('data-step', count_task);
      console.log($(a).attr('data-intro'));
      chrome.extension.sendMessage({
        action: "task",
        name: name,
        text: text,
        object: current_element
      });
      load_one_style("fix.css");
      $('#myModal').modal('hide');
      is_show_modal = false;
    } else {
      if (!is_show_modal) {
        count_task += 1;
        console.log("click", $(e.target)[0].id, $(e.target)[0].outerHTML);
        remove_one("fix.css");
        current_element = $(e.target)[0].outerHTML;
        $('#myModal').modal('show');
        is_show_modal = true;
      }
    }
    if ($(e.target)[0].id === "close_data") {
      load_one_style("fix.css");
      $('#myModal').modal('hide');
      return is_show_modal = false;
    }
  };

  $.ready = function() {
    console.log("main");
    return chrome.extension.onMessage.addListener(function(request, sender, sendResponse) {
      console.log("page.coffee", request.action);
      switch (request.action) {
        case "start":
          $("body").on("click", click);
          loads();
          return console.log("page chrome.extension start");
        case "stop":
          $("body").off("click", click);
          removes();
          return console.log("page chrome.extension stop");
      }
    });
  };

  form_create = "<div id=\"myModal\" class=\"modal hide fade\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"myModalLabel\" aria-hidden=\"true\" style=\"width: 360px;top: 50%;\">\n        <div class=\"modal-header\">\n          <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">&times;</button>\n          <h3 id=\"myModalLabel\">Modal Heading</h3>\n        </div>\n        <div class=\"modal-body\">\n          <div class=\"control-group\">\n            <label class=\"control-label\" for=\"inputEmail\">Name</label>\n            <div class=\"controls\">\n              <input type=\"text\" id=\"inputName\" placeholder=\"Name\">\n            </div>\n          </div>\n          <div class=\"control-group\">\n            <label class=\"control-label\" for=\"inputText\">Description</label>\n            <div class=\"controls\">\n              <textarea rows=\"3\" id=\"inputText\"></textarea>\n            </div>\n          </div>\n          \n        </div>\n        <div class=\"modal-footer\">\n          <button class=\"btn\" data-dismiss=\"modal\" id=\"close_data\">Close</button>\n          <button class=\"btn btn-primary\" id=\"save_send_data\">Save changes</button>\n        </div>\n      </div>";

}).call(this);
