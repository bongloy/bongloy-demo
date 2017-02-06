require 'rails_helper'

describe "Authentication" do
  def setup_scenario
    visit(root_path)
  end

  before do
    setup_scenario
  end

  describe "Signing in through Facebook" do
    let(:omniauth) { Bongloy::SpecHelpers::OmniAuth.new(omniauth_options) }
    let(:omniauth_options) { {} }
    let(:asserted_email) { omniauth.email }

    def setup_scenario
      super
      omniauth
      connect_with_facebook
    end

    context "successfully" do
      def assert_logged_in!
        within_navbar { expect(page).to have_no_content(sign_in_link_text) }
      end

      it { assert_logged_in! }
    end

    context "unsuccessfully" do
      let(:omniauth_options) { { :email => "" } }

      def assert_not_logged_in!
        within_navbar { expect(page).to have_content(sign_in_link_text) }
      end

      it { assert_not_logged_in! }
    end
  end
end
