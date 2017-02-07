require 'rails_helper'

describe "Checkout" do
  let(:user) { create(:user) }

  def setup_scenario
  end

  before do
    setup_scenario
  end

  context "given I'm on '/checkout'" do
    let(:query) { {:name => "My Store", :description => "My Description"} }

    def setup_scenario
      super
      visit(checkout_path(query))
    end

    def assert_show!
      expect(page).to have_content(query[:name])
      expect(page).to have_content(query[:description])
    end

    it { assert_show! }
  end
end
