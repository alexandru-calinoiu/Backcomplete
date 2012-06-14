describe "show", ->
  describe "initializa", ->
    it "should set the value property to name by default", ->
      view = new Backcomplete.Views.Autocomplete.ShowView()
      expect(view.valueProperty).toEqual("name")
    it "should set the value property to options", ->
      view = new Backcomplete.Views.Autocomplete.ShowView({ valueProperty: "some_other_complicated_name" })
      expect(view.valueProperty).toEqual("some_other_complicated_name")
    it "should set the collection from options", ->
      collection = new Backcomplete.Collections.SearchResultsCollection()
      view = new Backcomplete.Views.Autocomplete.ShowView({ collection: collection })
      expect(view.collection).toEqual(collection)
    it "should set the category_property to defaut", ->
      view = new Backcomplete.Views.Autocomplete.ShowView()
      expect(view.categoryProperty).toEqual("category")
    it "should set category_property from options", ->
      view = new Backcomplete.Views.Autocomplete.ShowView({ categoryProperty: "some_category_property" })
      expect(view.categoryProperty).toEqual("some_category_property")

  describe "_renderMenu", ->
    beforeEach ->
      @view = new Backcomplete.Views.Autocomplete.ShowView()
    it "should render a category", ->
      ul = { append: -> return }
      spy = sinon.spy(ul, "append")
      @view._renderMenu(ul, [{ name: "test", category: "cat" }])
      expect(spy.withArgs("<li class='ui-menu-category'>cat</li>").called).toBeTruthy()
    it "should not render the same category twice", ->
      ul = { append: -> return }
      spy = sinon.spy(ul, "append")
      @view._renderMenu(ul, [{ name: "test", category: "cat" }, { name: "test1", category: "cat" }])
      expect(spy.withArgs("<li class='ui-menu-category'>cat</li>").calledOnce).toBeTruthy()

  describe "_autoCompleteSource", ->
    it "should call fetch with the right term", ->
      collection = { fetch: (term) -> }
      view = new Backcomplete.Views.Autocomplete.ShowView({ collection: collection })
      spy = sinon.spy(collection, "fetch")
      view._autoCompleteSource({ term: "term" })
      expect(spy.withArgs("term").called).toBeTruthy()
