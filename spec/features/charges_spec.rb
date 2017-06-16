require 'rails_helper'

describe "Charges" do
  def setup_scenario
  end

  before do
    setup_scenario
  end

  context "given I'm on '/charges/new'" do
    let(:query) { {} }

    let(:user) { create(:user) }
    let(:checkout_configuration_attributes) { attributes_for(:checkout_configuration, :custom) }
    let(:checkout_configuration) {
      create(
        :checkout_configuration, checkout_configuration_attributes.merge(:user => user)
      )
    }

    let(:omniauth_options) { {:email => user.email} }
    let(:omniauth) { Bongloy::SpecHelpers::OmniAuth.new(omniauth_options) }

    def sign_in
      omniauth
      connect_with_facebook
    end

    def visit_new_charge_path
      visit(new_charge_path(query))
    end

    def setup_scenario
      super
      visit_new_charge_path
    end

    def assert_new_charge_page!
      within_navbar do
        expect(page).to have_link("Documentation", :href => "https://www.bongloy.com/documentation")
        expect(page).to have_link("Source Code", :href => "https://github.com/dwilkie/bongloy-demo")
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
      def setup_scenario
        super
        checkout_configuration
        sign_in
      end

      def assert_personalized_page!
        expect(page).to have_no_selector("#personalize_alert")
        within_bongloy_checkout_snippit do
          expect(page).to have_content(checkout_configuration_attributes[:name])
          expect(page).to have_content(checkout_configuration_attributes[:label])
        end
      end

      it { assert_personalized_page! }
    end

    context "and I update the default checkout configuration" do
      let(:checkout_configuration_options) { {} }

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

      let(:button_text) { ENV["BONGLOY_CHECKOUT_DEFAULT_LABEL"] }

      def within_payment_form(&block)
        within("form#new_charge") do
          yield
        end
      end

      def form_inputs
        {:card_number => nil}
      end

      def find_form_group(form_input)
        within_payment_form do
          page.find("##{form_input}")
        end
      end

      def card_number_input(options = {})
        find_field("Card Number", options)
      end

      def card_expiry_input(options = {})
        find_field("Expires MM/YY", options)
      end

      def card_cvc_input(options = {})
        find_field("Security Code / PIN", options)
      end

      def fill_in_card_number(options = {})
        native_fill_in(card_number_input, options)
      end

      def fill_in_card_expiry(options = {})
        native_fill_in(card_expiry_input, options)
      end

      def fill_in_card_cvc(options = {})
        native_fill_in(card_cvc_input, options)
      end

      def valid_expiry
        1.month.from_now.strftime("%m%y")
      end

      def assert_payment_form_before_submit!
      end

      def submit_form
        click_button(button_text)
      end

      def fill_out_payment_form(options = {})
        card = options[:card] || {}
        expiry = card[:expiry] || valid_expiry
        cvc = card[:cvc] || "123"

        within_payment_form do
          fill_in_card_number(:with => card[:number], :tab_after_input => true)
          fill_in_card_expiry(:with => expiry, :tab_after_input => true) if card[:expiry] != false
          fill_in_card_cvc(:with => cvc, :tab_after_input => true) if card[:cvc] != false
          assert_payment_form_before_submit!
          submit_form
        end
      end

      context "without filling in the form" do
        def setup_scenario
          super
          fill_out_payment_form
        end

        def assert_form_errors!
          form_inputs.keys.each do |form_input_id|
            form_group = find_form_group(form_input_id)
            expect(form_group[:class]).to include("has-error")
          end
        end

        it { assert_form_errors! }
      end

      context "filling in the form" do
        let(:api_helpers) { Bongloy::SpecHelpers::ApiHelpers.new }
        let(:bongloy_charges_uri) { URI.parse(api_helpers.charges_url) }

        let(:bongloy_charge_requests) {
          WebMock.requests.select { |request|
            request.uri.host == bongloy_charges_uri.host && request.uri.path == bongloy_charges_uri.path
          }
        }

        def setup_scenario
          super
          api_helpers.stub_create_customer
          api_helpers.stub_create_charge
          fill_out_payment_form(:card => card)
        end

        def parse_request_body(request_body)
          WebMock::Util::QueryMapper.query_to_values(request_body)
        end

        def assert_successful_charge!
          within_flash do
            expect(page).to have_link(ENV["BONGLOY_CHARGES_URL"])
            expect(page).to have_content(ENV["BONGLOY_TEST_ACCOUNT_EMAIL"])
            expect(page).to have_content(ENV["BONGLOY_TEST_ACCOUNT_PASSWORD"])
          end
          expect(bongloy_charge_requests.count).to eq(1)
        end

        context "without signing in" do
          context "with my Visa Card" do
            let(:card) { {:number => "4242424242424242", :cvc => "123"}  }
            it { assert_successful_charge! }
          end
        end

        context "while signed in" do
          let(:checkout_configuration_attributes) { {:amount_cents => 50} }
          let(:button_text) { checkout_configuration[:label] }

          def setup_scenario
            checkout_configuration
            visit_new_charge_path
            sign_in
            super
          end

          def assert_successful_charge!
            super
            bongloy_charge_request = bongloy_charge_requests.first
            bongloy_charge_request_body = parse_request_body(bongloy_charge_request.body)
            expect(bongloy_charge_request_body["amount"]).to eq("50")
          end

          context "with my ACLEDA Card" do
            let(:card) { {:number => "9116011234567885", :expiry => false, :cvc => false} }

            def submit_form
              # remove when API is enabled for ACLEDA cards
            end

            def assert_successful_charge!
              # remove when API is enabled for ACLEDA cards
            end

            def assert_payment_form_before_submit!
              expect(card_number_input).not_to be_disabled
              expect(card_expiry_input(:disabled => true)).to be_disabled
              expect(card_cvc_input(:disabled => true)).to be_disabled
            end

            it { assert_successful_charge! }
          end
        end
      end
    end
  end
end
