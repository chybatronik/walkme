window.WalkMe =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Actions: {}
  initialize: -> alert 'Hello from Backbone!'

_.templateSettings =
  interpolate: /\{\{\=(.+?)\}\}/g
  evaluate: /\{\{(.+?)\}\}/g
  
$(document).ready ->
  WalkMe.initialize()
