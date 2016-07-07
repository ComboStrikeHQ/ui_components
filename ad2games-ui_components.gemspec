# frozen_string_literal: true
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'ui_components/version'

Gem::Specification.new do |s|
  s.name = 'ad2games-ui_components'

  s.version = UiComponents::VERSION

  s.authors = ['ad2games']
  s.email = ['developers@ad2games.com']
  s.homepage = 'http://www.ad2games.com'
  s.summary = 'UI components for ad2games projects'
  s.license = 'MIT'

  s.files = Dir[
    '{app,lib,config}/**/*',
    'vendor/assets/bower_components/**/*',
    'MIT-LICENSE',
    'Rakefile',
    'README.rdoc'
  ]

  s.add_dependency 'rails', '~> 4.2.0'
  s.add_dependency 'cells', '~> 4.1.1'
  s.add_dependency 'cells-rails', '~> 0.0.5'
  s.add_dependency 'cells-slim', '>= 0.0.3'

  s.add_dependency 'slim-rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'uglifier'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'turbolinks', '< 5'

  s.add_dependency 'bootstrap-sass'
  s.add_dependency 'bootstrap_form'
  s.add_dependency 'rails_bootstrap_navbar'
  s.add_dependency 'bootstrap-datepicker-rails'
  s.add_dependency 'bower-rails'

  s.add_dependency 'jquery-turbolinks'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara-webkit'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'datagrid'
end
