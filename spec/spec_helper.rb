ENV['RAILS_ENV'] = 'test'

if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

require File.expand_path('../dummy/config/environment.rb', __FILE__)

require 'rspec/rails'
require 'pry-rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new app, phantomjs_logger: StringIO.new
end
Capybara.javascript_driver = :poltergeist

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(ENGINE_RAILS_ROOT, 'spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include JsConsole
  config.include ChosenSelect
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  config.before do
    clear_console_messages
  end
end

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
load File.expand_path('../dummy/db/schema.rb', __FILE__)
