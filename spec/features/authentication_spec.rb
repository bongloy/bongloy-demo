require 'rails_helper'

describe "Authentication" do
  let(:new_user) { User.where(:email => asserted_email).first! }

  describe "Signing up" do
    context "given I'm on the sign in page" do
      before do
        visit new_user_session_path
      end

      context "and I click 'Sign up'" do
        before do
          click_link("Sign up")
        end

        it "should take me to the sign up page" do
          expect(current_path).to eq(new_user_registration_path)
        end
      end

      context "and I connect with Facebook" do
        let(:omniauth) { Bongloy::SpecHelpers::OmniAuth.new(omniauth_options) }
        let(:asserted_email) { omniauth.email }
        let(:omniauth_options) { {} }

        def connect_with_facebook
          click_link("Sign in with Facebook")
        end

        before do
          omniauth
          connect_with_facebook
        end

        context "successfully" do
          it "should log me in" do
            expect(current_path).to eq(user_root_path)

            within_user_navbar do
              expect(page).to have_content(omniauth.first_name)
            end
          end
        end

        context "unsuccessfully" do
          let(:omniauth_options) { { :email => ""} }
          it "take me to the sign up page" do
            expect(current_path).to eq(new_user_registration_path)
          end
        end
      end
    end

    context "given I'm on the sign up page" do
      before do
        visit new_user_registration_path
      end

      let(:asserted_email) { "someone@example.com" }

      context "and I fill in the required details" do
        before do
          fill_in("Email", :with => asserted_email)
          fill_in("Password", :with => "secret123", :match => :prefer_exact)
          fill_in("Password confirmation", :with => "secret123", :match => :prefer_exact)
          click_button("Sign up")
        end

        it "should take me to the dashboard" do
          expect(current_path).to eq(user_root_path)
          within_user_navbar do
            expect(page).to have_content(asserted_email)
          end
        end
      end
    end
  end

  describe "Signing in" do
    context "given I'm on the homepage and I click 'Sign in'" do
      before do
        visit root_path
        within_user_navbar do
          click_link("Sign in")
        end
      end

      it "should take me to the sign in page" do
        expect(current_path).to eq(new_user_session_path)
      end
    end

    context "after signing in" do
      let(:user) { create(:user, :first_name => "Andy", :password => "secret123") }

      before do
        sign_in(:user => user, :password => "secret123")
      end

      it "should show me my name in the context menu" do
        within_user_navbar do
          expect(page).to have_content("Andy")
        end
      end

      context "when I log out" do
        before do
          within_user_navbar do
            click_link("Sign out")
          end
        end

        it "should log me out" do
          within_user_navbar do
            expect(page).to have_link("Sign in")
          end
        end
      end
    end
  end
end
