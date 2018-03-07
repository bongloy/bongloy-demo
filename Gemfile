source 'https://rubygems.org'

ruby(File.read(".ruby-version").strip) if ENV["GEMFILE_LOAD_RUBY_VERSION"].to_i == 1 && File.exist?(".ruby-version")

gem 'rails', '5.1.5'
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
gem 'simple_form'
gem 'money-rails'
gem 'stripe'

group :development, :test do
  gem 'rspec-rails'
  gem 'foreman'
  gem 'pry'
  gem 'dotenv-rails'
end

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'webmock'
end

group :production do
  gem 'rails_12factor'
end
