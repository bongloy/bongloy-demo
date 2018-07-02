source "https://rubygems.org"

if ENV["GEMFILE_LOAD_RUBY_VERSION"].to_i == 1 && File.exist?(".ruby-version")
  ruby(File.read(".ruby-version").strip)
end

gem "autoprefixer-rails"
gem "bootstrap-sass"
gem "haml"
gem "jbuilder"
gem "jquery-rails"
gem "puma"
gem "rails", "5.1.6"
gem "sass-rails"
gem "simple_form"
gem "stripe"
gem "uglifier"

group :development, :test do
  gem "dotenv-rails"
  gem "foreman"
  gem "pry"
  gem "rspec-rails"
end

group :development do
  gem "spring"
  gem "spring-commands-rspec"
end

group :test do
  gem "factory_bot_rails"
  gem "shoulda-matchers"
  gem "webmock"
end

group :production do
  gem "rails_12factor"
end
