require 'capybara/rails'
require 'capybara/rspec'

Capybara.asset_host = "http://localhost:5000"

Capybara.default_wait_time = 20
