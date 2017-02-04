require "rails_helper"

RSpec.describe BowlersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/bowlers").to route_to("bowlers#index")
    end

    it "routes to #new" do
      expect(:get => "/bowlers/new").to route_to("bowlers#new")
    end

    it "routes to #show" do
      expect(:get => "/bowlers/1").to route_to("bowlers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/bowlers/1/edit").to route_to("bowlers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/bowlers").to route_to("bowlers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/bowlers/1").to route_to("bowlers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/bowlers/1").to route_to("bowlers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/bowlers/1").to route_to("bowlers#destroy", :id => "1")
    end

  end
end
