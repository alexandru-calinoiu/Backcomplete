#bind to the select
#
#html5 attributes

Backcomplete.Views.Autocomplete ||= {}

class Backcomplete.Views.Autocomplete.ShowView extends Backbone.View
  tagName: "input"

  initialize: (options) ->
    options ||= {}
    @collection = options.collection || new Backbone.Collection.extend()
    @valueProperty = options.valueProperty || "name"
    @categoryProperty = options.categoryProperty || "category"
    @renderItem = options.renderItem || @_renderItem
    @renderMenu = options.renderMenu || @_renderMenu
    @renderNoResult = options.renderNoResult
    @html = options.html || {}

  render: ->
    element = $(@el)
    autocomplete = element.autocomplete({ source: @_autoCompleteSource }).data('autocomplete')
    autocomplete._renderMenu = @renderMenu
    autocomplete._renderItem = @renderItem

    $.each(@html, (key, value) -> element.attr(key, value) )

    return this

  _autoCompleteSource: (request, response) =>
    @collection.fetch(request.term, {
    success: (collection, resp) =>
      if collection.length == 0
        collection.add({ value: "no result", label: "no result" })

      response(_.map(collection.models, (model) =>
        # we need this for the up down arrorw to work
        json = model.toJSON()
        json.value = model.get(@valueProperty)
        json
      ))
    })

  _renderMenu: (ul, items) =>
    currentCategory = ""
    _.each(items, (item) =>
      if item.category != currentCategory && !!item.category
        ul.append("<li class='ui-menu-category'>" + item.category + "</li>")
      currentCategory = item.category

      if item.value == "no result" && @renderNoResult != null
        @renderNoResult(ul)
      else
        @renderItem(ul, item)
    )

  _renderItem: (ul, item) =>
    $("<li class='ui-menu-item'></li>")
      .data("item.autocomplete", item)
      .append("<a>#{item[@valueProperty]}</a>")
      .appendTo(ul);