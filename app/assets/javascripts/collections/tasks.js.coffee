class WalkMe.Collections.Tasks extends Backbone.Collection
  localStorage: new Backbone.LocalStorage("App_Collections_Tasks")  
  model: WalkMe.Models.Task
