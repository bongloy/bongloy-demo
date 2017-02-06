module Bongloy::SpecHelpers::FeatureHelpers::NavigationHelpers
  private

  def within_navbar(&block)
    within("#main_navbar") do
      yield
    end
  end

  def sign_in_link_text
    "Sign In"
  end

  def connect_with_facebook
    within_navbar do
      click_link(sign_in_link_text)
    end
  end

  def within_flash(&block)
    within("#flash") do
      yield
    end
  end
end
