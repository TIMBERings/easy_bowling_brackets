require "rails_helper"

RSpec.describe BracketsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/brackets").to route_to("brackets#index")
    end

    it "routes to #new" do
      expect(:get => "/brackets/new").to route_to("brackets#new")
    end

    it "routes to #show" do
      expect(:get => "/brackets/1").to route_to("brackets#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/brackets/1/edit").to route_to("brackets#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/brackets").to route_to("brackets#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/brackets/1").to route_to("brackets#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/brackets/1").to route_to("brackets#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/brackets/1").to route_to("brackets#destroy", :id => "1")
    end

  end
end
