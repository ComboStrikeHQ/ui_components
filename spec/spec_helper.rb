# frozen_string_literal: true
ENV['RAILS_ENV'] = 'test'

if ENV['CI'] || ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    minimum_coverage 98
    add_filter '/spec/dummy'
    add_filter '/spec/support'
  end
end

require File.expand_path('../dummy/config/environment.rb', __FILE__)

require 'rspec/rails'
require 'pry-rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

JS_LOGGER = StringIO.new
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, phantomjs_logger: JS_LOGGER)
end
Capybara.javascript_driver = :poltergeist

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(ENGINE_RAILS_ROOT, 'spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include ChosenSelect
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  config.before :each do
    JS_LOGGER.rewind
    JS_LOGGER.truncate(0)
  end
end
