require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.asset_host = "http://localhost:5000"

Capybara.default_max_wait_time = 20
Capybara.javascript_driver = :poltergeist
