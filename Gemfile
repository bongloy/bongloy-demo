source 'https://rubygems.org'

ruby(File.read(".ruby-version").strip) if ENV["GEMFILE_LOAD_RUBY_VERSION"].to_i == 1 && File.exist?(".ruby-version")

gem 'rails', '5.0.1'
gem 'devise'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jbuilder'
gem 'haml'
gem 'puma'
gem 'pg'
gem 'font-awesome-rails'
gem 'bootstrap-sass'
gem 'autoprefixer-rails'
gem 'omniauth-facebook'
gem 'bongloy', :github => "dwilkie/bongloy-ruby"
gem 'simple_form', :github => "plataformatec/simple_form"
gem 'rails-assets-jquery.payment.cambodia', :source => 'https://rails-assets.org'
gem 'bootswatch-rails'

group :development, :test do
  gem 'rspec-rails'
  gem 'foreman'
  gem 'pry'
  gem 'dotenv'
end

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem "bongloy-spec-helpers", :github => "dwilkie/bongloy-spec-helpers"
end

group :production do
  gem 'rails_12factor'
end
