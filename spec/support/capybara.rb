Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :firefox,
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.firefox(marionette: false)
  )
end
