require 'rails_helper'

describe "Charges", :js do
  let(:user) { create(:user) }

  before do |example|
    sign_in(:user => user, :example => example)
  end

  context "when I navigate to '/dashboard'" do
    before do
      visit user_root_path
      within_resources_navbar do
        click_link("Home")
      end
    end

    it "should take me to '/dashboard'" do
      expect(current_path).to eq(user_root_path)
    end
  end

  context "given I'm on '/dashboard'" do
    before do
      visit user_root_path
    end

    context "and I test out payment using bongloy.js", :js do
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

      context "without filling in the form" do
        before do
          fill_out_payment_form
        end

        it "should highlight the errors on the form" do
          form_inputs.keys.each do |form_input_id|
            form_group = find_form_group(form_input_id)
            expect(form_group[:class]).to include("has-error")
          end
        end
      end

      context "filling in the form using my" do
        let(:api_helpers) { Bongloy::SpecHelpers::ApiHelpers.new }

        before do
          api_helpers.stub_create_customer
          api_helpers.stub_create_charge
          fill_out_payment_form(:card => card)
        end

        context "Visa Card" do
          let(:card) { {:number => "4242424242424242", :cvc => "123"}  }

          it "should show a link to the newly created charge on Bongloy" do
            within_flash do
              expect(page).to have_link(Rails.application.secrets[:bongloy_charges_url])
              expect(page).to have_content(Rails.application.secrets[:bongloy_test_account_email])
              expect(page).to have_content(Rails.application.secrets[:bongloy_test_account_password])
            end
          end
        end
      end
    end
  end
end
