describe "show", ->
  describe "initializa", ->
    it "should set the value property to name by default", ->
      view = new Backcomplete.Views.Autocomplete.ShowView()
      expect(view.value_property).toEqual("name")
    it "should set the value property to options", ->
      view = new Backcomplete.Views.Autocomplete.ShowView({ value_property: "some_other_complicated_name" })
      expect(view.value_property).toEqual("some_other_complicated_name")
    it "should set the collection from options", ->
      collection = new Backcomplete.Collections.SearchResultsCollection()
      view = new Backcomplete.Views.Autocomplete.ShowView({ collection: collection })
      expect(view.collection).toEqual(collection)
    it "should set the category_property to defaut", ->
      view = new Backcomplete.Views.Autocomplete.ShowView()
      expect(view.category_property).toEqual("category")
    it "should set category_property from options", ->
      view = new Backcomplete.Views.Autocomplete.ShowView({ category_property: "some_category_property" })
      expect(view.category_property).toEqual("some_category_property")

  describe "renderMenu", ->
    beforeEach ->
      @view = new Backcomplete.Views.Autocomplete.ShowView()
    it "should render a category", ->
      ul = { append: -> return }
      spy = sinon.spy(ul, "append")
      @view.renderMenu(ul, [{ name: "test", category: "cat" }])
      expect(spy.withArgs("<li class='ui-menu-category'>cat</li>").called).toBeTruthy()
    it "should not render the same category twice", ->
      ul = { append: -> return }
      spy = sinon.spy(ul, "append")
      @view.renderMenu(ul, [{ name: "test", category: "cat" }, { name: "test1", category: "cat" }])
      expect(spy.withArgs("<li class='ui-menu-category'>cat</li>").calledOnce).toBeTruthy()

  describe "autoCompleteSource", ->
    it "should call fetch with the right term", ->
      collection = { fetch: (term) -> }
      view = new Backcomplete.Views.Autocomplete.ShowView({ collection: collection })
      spy = sinon.spy(collection, "fetch")
      view.autoCompleteSource({ term: "term" })
      expect(spy.withArgs("term").called).toBeTruthy()
