describe 'SearchResultsCollection', ->
  describe 'fetch', ->
    it "should point to /search/:term", ->
      collection = new Backcomplete.Collections.SearchResultsCollection()
      sinon.stub(Backbone.Collection.prototype.fetch, "call")
      collection.fetch("test")
      expect(collection.url()).toEqual('/search/test')
