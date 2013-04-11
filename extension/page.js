// Generated by CoffeeScript 1.6.2
(function() {
  var click, load,
    _this = this;

  console.log("page load");

  load = function() {
    var style;

    style = document.createElement('link');
    style.rel = 'stylesheet';
    style.type = 'text/css';
    style.href = chrome.extension.getURL('fix.css');
    return (document.head || document.documentElement).appendChild(style);
  };

  click = function(e) {
    e.preventDefault();
    console.log("click", e.target, $(e.target)[0].outerHTML);
    return chrome.extension.sendMessage({
      action: "task",
      object: $(e.target)[0].outerHTML
    });
  };

  $("body").on("click", click);

  load();

  console.log("page chrome.extension");

  $.ready = function() {
    return chrome.extension.onMessage.addListener(function(request, sender, sendResponse) {
      return console.log("page.coffee", request);
    });
  };

}).call(this);