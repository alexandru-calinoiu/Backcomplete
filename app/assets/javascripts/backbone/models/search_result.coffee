class Backcomplete.Models.SearchResult extends Backbone.Model
  paramRoot: 'search_result'

class Backcomplete.Collections.SearchResultsCollection extends Backbone.Collection
  model: Backcomplete.Models.SearchResult
  url: => "/search/#{@searchTerm}"
  fetch: (searchTerm, options) =>
    @searchTerm = searchTerm
    Backbone.Collection.prototype.fetch.call(this, options)
