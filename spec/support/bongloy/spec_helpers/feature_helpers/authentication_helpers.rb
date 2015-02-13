require_relative "form_helpers"

module Bongloy
  module SpecHelpers
    module FeatureHelpers
      module AuthenticationHelpers
        include ::Bongloy::SpecHelpers::FeatureHelpers::FormHelpers

        private

        def sign_in(options = {})
          password = options.delete(:password) || "secret123"
          user = options.delete(:user) || create(:user, :password => password)
          visit new_user_session_path
          fill_in_method = options[:example] && options[:example].metadata[:js] ? :native_fill_in : :fill_in
          send(fill_in_method, "Email", :with => user.email)
          send(fill_in_method, "Password", :with => password)
          click_button("Sign in")
        end
      end
    end
  end
end
