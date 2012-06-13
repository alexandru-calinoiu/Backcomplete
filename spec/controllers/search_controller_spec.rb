require 'spec_helper'

describe SearchController do

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      response.should be_success
    end
    it "should return a collection of results" do
      get :index, :term => "ruby"
      assigns(:results).length.should == 1
    end
  end

end
