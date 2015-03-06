$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'ui_components/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ui_components'
  s.version     = UiComponents::VERSION
  s.authors     = ['Helge Rausch']
  s.email       = ['helge@rausch.io']
  s.homepage    = 'TODO'
  s.summary     = 'TODO: Summary of UiComponents.'
  s.description = 'TODO: Description of UiComponents.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '~> 4.2.0'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara-webkit'
  s.add_development_dependency 'slim-rails'
  s.add_development_dependency 'pry-rails'
end
