Backcomplete.Views.Autocomplete ||= {}

class Backcomplete.Views.Autocomplete.ShowView extends Backbone.View
  tagName: "input"

  initialize: (options) ->
    options ||= {}
    @collection = new Backcomplete.Collections.SearchResultsCollection()
    @value_property = options.value_property || "name"

  render: ->
    # huge method that need refactoring
    $(@el).autocomplete({
    source: (request, response) =>
      @collection.fetch(request.term, {
      success: (collection, resp) =>
        response(_.map(collection.models, (model) =>
          {
          label: model.get(@value_property)
          value: model.get(@value_property)
          category: model.get("category")
          }
        ))
      })
    }).data('autocomplete')._renderMenu = (ul, items) ->
      currentCategory = "";
      _.each(items, (item) =>
        if (item.category != currentCategory)
          ul.append( "<li class='ui-menu-category'>" + item.category + "</li>")
        currentCategory = item.category
        this._renderItem(ul, item)
      )

    return this