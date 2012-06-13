Backcomplete.Views.Autocomplete ||= {}

class Backcomplete.Views.Autocomplete.ShowView extends Backbone.View
  tagName: "input"

  initialize: (options) ->
    options ||= {}
    @collection = new Backcomplete.Collections.SearchResultsCollection()
    @value_property = options.value_property || "name"

  render: ->
    $(@el).autocomplete({
    source: (request, response) =>
      @collection.fetch(request.term, {
      success: (collection, resp) =>
        response($.map(collection.models, (model) =>
          {
          label: model.get(@value_property)
          value: model.get(@value_property)
          }
        ))
      })
    }).data('autocomplete')._renderItem = (ul, item) =>
      $('<li/>')
      .data('item.autocomplete', item.value)
      .append($('<a/>').text(item.value))
      .appendTo(ul)

    return this