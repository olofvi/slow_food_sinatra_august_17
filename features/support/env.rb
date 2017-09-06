ENV['RACK_ENV'] = 'test'

require './lib/controller.rb'

require 'capybara'
require 'capybara/cucumber'
require 'rspec'
require 'pry'
require 'database_cleaner'
require 'database_cleaner/cucumber'

Capybara.app = SlowFood

class SlowFoodWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

DatabaseCleaner.strategy = :truncation

Around do | scenario, block|
  DatabaseCleaner.cleaning(&block)
end

World do
  SlowFood.new
end

Warden.test_mode!
World Warden::Test::Helpers
After {
  Warden.test_reset!
}
