RSpec.configure do |config|
  # use truncation for js tests only
  config.around(:each, :js => true) do |example|
    original_use_transactional_fixtures = use_transactional_fixtures
    self.use_transactional_fixtures = false
    ActiveRecord::Base.establish_connection
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
    example.run
    DatabaseCleaner.clean
    ActiveRecord::Base.establish_connection
    self.use_transactional_fixtures = original_use_transactional_fixtures
  end
end
