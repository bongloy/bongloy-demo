require 'rails_helper'

RSpec.describe "Tax::Vehicles", type: :request do
  describe "GET /tax/vehicles" do
    it "works! (now write some real specs)" do
      get tax_vehicles_path
      expect(response).to have_http_status(200)
    end
  end
end
