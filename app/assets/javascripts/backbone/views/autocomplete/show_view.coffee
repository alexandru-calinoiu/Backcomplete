#render_item
#render_menu
#
#don't render categories (just go with the default)
#
#bind to the select
#
#html5 attributes
#
#change to camel case

Backcomplete.Views.Autocomplete ||= {}

class Backcomplete.Views.Autocomplete.ShowView extends Backbone.View
  tagName: "input"

  initialize: (options) ->
    options ||= {}
    @collection = options.collection || new Backbone.Collection.extend()
    @valueProperty = options.valueProperty || "name"
    @categoryProperty = options.categoryProperty || "category"

  render: ->
    autocomplete = $(@el).autocomplete({ source: @_autoCompleteSource }).data('autocomplete')
    autocomplete._renderMenu = @_renderMenu
    return this

  _autoCompleteSource: (request, response) =>
    @collection.fetch(request.term, {
    success: (collection, resp) =>
      response(_.map(collection.models, (model) =>
        {
        label: model.get(@valueProperty)
        value: model.get(@valueProperty)
        category: model.get("category")
        }
      ))
    })

  _renderMenu: (ul, items) ->
    currentCategory = ""
    _.each(items, (item) =>
      if (item.category != currentCategory)
        ul.append("<li class='ui-menu-category'>" + item.category + "</li>")
      currentCategory = item.category

      this._renderItem(ul, item)
    )