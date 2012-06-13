class Backcomplete.Routers.SearchRouter extends Backbone.Router
  routes:
    ".*" : "show"

  show: ->
    @view = new Backcomplete.Views.Autocomplete.ShowView()
    $("#placeholder").html(@view.render().el)
