require_relative "form_helpers"

module Bongloy::SpecHelpers::FeatureHelpers::AuthenticationHelpers
  include ::Bongloy::SpecHelpers::FeatureHelpers::FormHelpers

  private

  def sign_in(options = {})
    password = options.delete(:password) || "secret123"
    user = options.delete(:user) || create(:user, :password => password)
    visit(new_user_session_path)
    fill_in("Email", :with => user.email)
    fill_in("Password", :with => password)
    click_button("Sign in")
  end
end
