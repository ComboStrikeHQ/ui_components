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

Capybara.javascript_driver = :poltergeist

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(ENGINE_RAILS_ROOT, 'spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include SelectHelper
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end

dbconfig = YAML.load(File.read(File.expand_path('../dummy/config/database.yml', __FILE__)))
ActiveRecord::Base.establish_connection(dbconfig[:test])
load File.expand_path('../dummy/db/schema.rb', __FILE__)
