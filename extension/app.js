// Generated by CoffeeScript 1.6.2
(function() {
  var LoginView, NavigationView, User, login, main, send_content_script, user,
    _this = this;

  User = (function() {
    function User() {}

    User.prototype.set = function(data) {
      this.token = data.token;
      return this.email = data.email;
    };

    return User;

  })();

  user = new User;

  main = function() {
    var navigateview;
    $('.main').empty();
    return navigateview = new NavigationView();
  };

  login = function() {
    var loginview;
    return loginview = new LoginView();
  };

  LoginView = Backbone.View.extend({
    template: _.template($('#login-form').html()),
    initialize: function() {
      _.bindAll(this);
      this.render();
      return console.log("initialize LoginView", user.token);
    },
    events: {
      "click #submit": "get_token"
    },
    get_token: function(evt) {
      evt.preventDefault();
      return $.ajax({
        url: 'http://127.0.0.1:3000/api/v1/tokens.json',
        type: "POST",
        dataType: "json",
        data: {
          email: $('input.email').val(),
          password: $('input.password').val()
        },
        success: function(data, status, response) {
          /*token = data.token
          email = data.email
          */
          user.set(data);
          return main();
        }
      });
    },
    render: function() {
      this.$el.html(this.template());
      return $('.main').empty().append(this.el);
    }
  });

  /*CollectionStepView = Backbone.View.extend(
    template: _.template($('#collection_step_view').html())
  
    initialize:->   
      _.bindAll @
      @.render()
      console.log "initialize CollectionStepView"
  
    render:->
      collection = ['asd', 'asdasd', 'asdasdasd']
      #this.$el.html(this.template());
      this.$el.append( this.template() );
      $('#workspace-panel').empty().append(this.el)
  )
  */


  NavigationView = Backbone.View.extend({
    template: _.template($('#navigation_view').html()),
    initialize: function() {
      _.bindAll(this);
      this.render();
      return console.log("initialize NavigationView", user.token);
    },
    events: {
      "click #help": "help",
      "click #workspace": "workspace",
      "click #setting": "setting",
      "click #publish": "publish",
      "click #logout": "logout",
      "click #start": "start",
      "click #stop": "stop",
      "click #play": "play"
    },
    start: function(ev) {
      ev.preventDefault();
      return send_content_script("start");
    },
    stop: function(ev) {
      ev.preventDefault();
      return send_content_script("stop");
    },
    play: function(ev) {
      ev.preventDefault();
      return send_content_script("play");
    },
    help: function(ev) {
      return ev.preventDefault();
    },
    workspace: function(ev) {
      return console.log("workspace", ev.target, $(ev.target).attr('id'));
    },
    setting: function(ev) {
      return console.log("setting", ev.target, $(ev.target).attr('id'));
    },
    publish: function(ev) {
      return console.log("publish", ev.target, $(ev.target).attr('id'));
    },
    logout: function(ev) {
      return console.log("logout", ev.target, $(ev.target).attr('id'));
    },
    render: function() {
      this.$el.html(this.template({
        name: user.email
      }));
      return $('.navigation').empty().append(this.el);
    }
  });

  send_content_script = function(action) {
    return chrome.tabs.query({
      "status": "complete",
      "windowId": chrome.windows.WINDOW_ID_CURRENT,
      "active": true
    }, function(tabs) {
      console.log(JSON.stringify(tabs[0]));
      console.log(tabs[0].id);
      return chrome.tabs.sendMessage(tabs[0].id, {
        action: action
      });
    });
  };

  $(window).load(login);

}).call(this);
