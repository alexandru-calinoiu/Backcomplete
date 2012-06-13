class Backcomplete.Models.SearchResult extends Backbone.Model
  paramRoot: 'search_result'

  defaults:

class Backcomplete.Collections.SearchResultsCollection extends Backbone.Collection
  model: Backcomplete.Models.SearchResult
  url: '/search_results'
