class Backcomplete.Routers.SearchRouter extends Backbone.Router
  routes:
    ".*": "show"

  show: ->
    simpleView = new Backcomplete.Views.Autocomplete.ShowView({
      collection: new Backcomplete.Collections.SearchResultsCollection()
      html: { autofocus: "autofocus" }
      select: (event, ui) ->
        console.log "Hey, you've just selected #{ui.item.name}"
    })
    $("#placeholder").html(simpleView.render().el)

    customRender = new Backcomplete.Views.Autocomplete.ShowView({
      collection: new Backcomplete.Collections.SearchResultsCollection()
      renderMenu: (ul, items) ->
        _.each(items, (item) =>
          this._renderItem(ul, item)
        )
      renderItem: (ul, item) ->
        $("<li class='ui-menu-item'></li>")
        .data("item.autocomplete", item)
        .append("<strong>#{item.name}</strong>")
        .appendTo(ul);
    })
    $("#custom").html(customRender.render().el)

    customRenderNoItems = new Backcomplete.Views.Autocomplete.ShowView({
    collection: new Backcomplete.Collections.SearchResultsCollection()
    renderNoResult: (ul) ->
      ul.append("<span>No items, do something about it</span>")
    })
    $("#customNoItems").html(customRenderNoItems.render().el)


