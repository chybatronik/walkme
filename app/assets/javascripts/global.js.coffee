# Underscrore template does not go well with HAML format.
# Use mustache one. Suggested on Google Groups @ HAML.
_.templateSettings =
  interpolate: /\{\{\=(.+?)\}\}/g
  evaluate: /\{\{(.+?)\}\}/g

@App =
  router: null
  player: null
  playlist: null
  Views: {}
  Models: {}
  Collections: {}

