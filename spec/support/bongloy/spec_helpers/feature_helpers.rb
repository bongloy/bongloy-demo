module Bongloy::SpecHelpers
  module FeatureHelpers
  end
end

require_relative "feature_helpers/authentication_helpers"
require_relative "feature_helpers/navigation_helpers"

RSpec.configure do |config|
  config.include ::Bongloy::SpecHelpers::FeatureHelpers::AuthenticationHelpers, :type => :feature
  config.include ::Bongloy::SpecHelpers::FeatureHelpers::NavigationHelpers, :type => :feature
end
