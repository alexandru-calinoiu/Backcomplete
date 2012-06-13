class SearchController < ApplicationController
  respond_to :json, :html

  class SearchResult
    attr_reader :category, :name

    def initialize(category, name)
      @category = category
      @name = name
    end
  end

  def index
    @results = search(params[:term])

    respond_with @results
  end

  private

  def search(term)
    collection = [SearchResult.new("old", "c"), SearchResult.new("old", "pascal"), SearchResult.new("new", "ruby"), SearchResult.new("new", "python")]

    collection.select { |i| (i.name =~ /#{term}/) }
  end
end
