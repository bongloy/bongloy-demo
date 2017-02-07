require 'rails_helper'

describe "Charges" do
  def setup_scenario
  end

  before do
    setup_scenario
  end

  context "given I'm on '/charges/new'" do
    let(:query) { {} }

    def setup_scenario
      super
      visit(new_charge_path(query))
    end

    def assert_new_charge_page!
      within_navbar do
        expect(page).to have_link("Bongloy Checkout")
        expect(page).to have_link("Bongloy.js")
        expect(page).to have_link("Documentation", :href => "https://www.bongloy.com/documentation")
        expect(page).to have_link("Bongloy Home", :href => "https://www.bongloy.com")
      end
      expect(page).to have_selector("#checkout_qr_code")
    end

    def within_bongloy_checkout_snippit(&block)
      within("#bongloy_checkout_snippit") do
        yield
      end
    end

    it { assert_new_charge_page! }

    context "and I signed in" do
      let(:user) { create(:user, :first_name => "David") }
      let(:checkout_configuration) { create(:checkout_configuration, :label => "My Label", :user => user) }
      let(:omniauth) { Bongloy::SpecHelpers::OmniAuth.new(omniauth_options) }
      let(:omniauth_options) { {:email => user.email, :first_name => user.first_name} }

      def setup_scenario
        super
        checkout_configuration
        omniauth
        connect_with_facebook
      end

      def assert_personalized_page!
        expect(page).to have_no_selector("#personalize_alert")
        within_bongloy_checkout_snippit do
          expect(page).to have_content("David's Shop")
          expect(page).to have_content("My Label")
        end
      end

      it { assert_personalized_page! }
    end

    context "and I update the default checkout configuration" do
      let(:checkout_configuration_options) { {} }
      let(:checkout_configuration_attributes) { attributes_for(:checkout_configuration, :custom) }

      def setup_scenario
        super
        update_checkout_configuration(checkout_configuration_options)
      end

      def update_checkout_configuration(options = {})
        fill_in(
          translate_label_for!(:amount),
          :with => options[:amount] || checkout_configuration_attributes[:amount_cents]
        )

        fill_in(
          translate_label_for!(:name),
          :with => options[:name] || checkout_configuration_attributes[:name]
        )

        fill_in(
          translate_label_for!(:description),
          :with => options[:description] || checkout_configuration_attributes[:description]
        )

        fill_in(
          translate_label_for!(:product_description),
          :with => options[:product_description] || checkout_configuration_attributes[:product_description]
        )

        fill_in(
          translate_label_for!(:label),
          :with => options[:label] || checkout_configuration_attributes[:label]
        )

        click_button("Update Configuration")
      end

      context "incorrectly" do
        let(:checkout_configuration_options) { { :description => ""} }

        def assert_checkout_configuration_errors!
          within("#merchant_view") do
            expect(page).to have_content(translate_simple_form!(:error_notification, :default_message))
          end
        end

        it { assert_checkout_configuration_errors! }
      end

      context "correctly" do
        def assert_update_checkout_configuration!
          within_flash do
            expect(page).to have_content("Checkout Configuration Updated!")
          end

          within_bongloy_checkout_snippit do
            expect(page).to have_content(checkout_configuration_attributes[:name])
          end
        end

        it { assert_update_checkout_configuration! }
      end
    end

    context "and I test out payment using bongloy.js", :js do
      include Bongloy::SpecHelpers::FeatureHelpers::FormHelpers

      def submit_form
        click_button("Pay with Bongloy")
      end

      def within_payment_form(&block)
        within("form#new_charge") do
          yield
        end
      end

      def form_inputs
        {:card_number => nil, :card_expiry => nil, :card_cvc => nil}
      end

      def find_form_group(form_input)
        within_payment_form do
          page.find("##{form_input}")
        end
      end

      def fill_in_card_number(options = {})
        native_fill_in("Card Number", options)
      end

      def fill_in_card_expiry(options = {})
        native_fill_in("Expires MM/YY", options)
      end

      def fill_in_card_cvc(options = {})
        native_fill_in("Security Code / PIN", options)
      end

      def valid_expiry
        1.month.from_now.strftime("%m%y")
      end

      def fill_out_payment_form(options = {})
        expiry = options[:expiry] || valid_expiry
        within_payment_form do
          if options[:card]
            fill_in_card_number(:with => options[:card][:number])
            fill_in_card_expiry(:with => expiry)
            fill_in_card_cvc(:with => options[:card][:cvc])
          end
          submit_form
        end
      end

      def assert_checkout_not_loaded!
        expect(page).to have_no_selector(:xpath, checkout_xpath)
      end

      def assert_checkout_loaded!
        expect(page).to have_selector(:xpath, checkout_xpath)
      end

      def checkout_xpath
        "//iframe[@name='stripe_checkout_app']"
      end

      context "and I pass load_checkout=1 as a query string" do
        let(:query) { {:load_checkout => 1} }
        it { assert_checkout_loaded! }
      end

      context "without filling in the form" do
        def setup_scenario
          super
          fill_out_payment_form
        end

        def assert_form_errors!
          assert_checkout_not_loaded!
          form_inputs.keys.each do |form_input_id|
            form_group = find_form_group(form_input_id)
            expect(form_group[:class]).to include("has-error")
          end
        end

        it { assert_form_errors! }
      end

      context "filling in the form using my" do
        let(:api_helpers) { Bongloy::SpecHelpers::ApiHelpers.new }

        def setup_scenario
          super
          api_helpers.stub_create_customer
          api_helpers.stub_create_charge
          fill_out_payment_form(:card => card)
        end

        context "Wing Card" do
          let(:card) { {:number => "5018188000001614", :cvc => "1234"}  }

          def assert_successful_charge!
            within_flash do
              expect(page).to have_link(ENV["BONGLOY_CHARGES_URL"])
              expect(page).to have_content(ENV["BONGLOY_TEST_ACCOUNT_EMAIL"])
              expect(page).to have_content(ENV["BONGLOY_TEST_ACCOUNT_PASSWORD"])
            end
          end

          it { assert_successful_charge! }
        end
      end
    end
  end
end
