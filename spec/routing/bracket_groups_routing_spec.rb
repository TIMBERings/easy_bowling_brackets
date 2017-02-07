require "rails_helper"

RSpec.describe BracketGroupsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/bracket_groups").to route_to("bracket_groups#index")
    end

    it "routes to #new" do
      expect(:get => "/bracket_groups/new").to route_to("bracket_groups#new")
    end

    it "routes to #show" do
      expect(:get => "/bracket_groups/1").to route_to("bracket_groups#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/bracket_groups/1/edit").to route_to("bracket_groups#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/bracket_groups").to route_to("bracket_groups#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/bracket_groups/1").to route_to("bracket_groups#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/bracket_groups/1").to route_to("bracket_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/bracket_groups/1").to route_to("bracket_groups#destroy", :id => "1")
    end

  end
end
