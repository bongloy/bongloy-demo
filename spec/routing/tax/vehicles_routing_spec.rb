require "rails_helper"

RSpec.describe Tax::VehiclesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/tax/vehicles").to route_to("tax/vehicles#index")
    end

    it "routes to #new" do
      expect(:get => "/tax/vehicles/new").to route_to("tax/vehicles#new")
    end

    it "routes to #show" do
      expect(:get => "/tax/vehicles/1").to route_to("tax/vehicles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/tax/vehicles/1/edit").to route_to("tax/vehicles#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/tax/vehicles").to route_to("tax/vehicles#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/tax/vehicles/1").to route_to("tax/vehicles#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/tax/vehicles/1").to route_to("tax/vehicles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/tax/vehicles/1").to route_to("tax/vehicles#destroy", :id => "1")
    end
  end
end
