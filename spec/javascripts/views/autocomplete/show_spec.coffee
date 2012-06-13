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