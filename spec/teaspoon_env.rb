ENV['TEASPOON_RAILS_ENV'] = File.expand_path('../dummy/config/environment', __FILE__)

Teaspoon.configure do |config|
  config.mount_at = '/teaspoon'
  config.root = UiComponents::Engine.root
  config.asset_paths = ['spec/javascripts', 'spec/javascripts/stylesheets']
  config.fixture_paths = ['spec/javascripts/fixtures']

  config.suite do |suite|
    suite.use_framework :jasmine
    suite.matcher = '{spec/javascripts,app/assets}/**/*_spec.{js,js.coffee,coffee}'
    suite.helper = 'spec_helper'
    suite.boot_partial = 'boot'
    suite.body_partial = 'body'
  end
end
