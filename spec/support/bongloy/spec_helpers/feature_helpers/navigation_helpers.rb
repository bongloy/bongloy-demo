module Bongloy::SpecHelpers::FeatureHelpers::NavigationHelpers
  private

  def within_resources_navbar(&block)
    within("#resources_navbar") do
      yield
    end
  end

  def within_user_navbar(&block)
    within("#user_navbar") do
      yield
    end
  end

  def within_flash(&block)
    within("#flash") do
      yield
    end
  end
end
