$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'ui_components'
  s.version     = '1.0.0'
  s.authors     = ['ad2games']
  s.email       = ['developers@ad2games.com']
  s.homepage    = 'TODO'
  s.summary     = 'TODO: Summary of UiComponents.'
  s.description = 'TODO: Description of UiComponents.'
  s.license     = 'MIT'

  s.files = Dir['{app,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'cells', '>= 4.0.0.beta2'
  s.add_dependency 'slim'
  s.add_dependency 'sass-rails'
  s.add_dependency 'compass-rails'
  s.add_dependency 'sprockets'

  s.add_dependency 'bootstrap-sass'
  s.add_dependency 'bootstrap_form'
  s.add_dependency 'chosen-rails'
  s.add_dependency 'rails-assets-bootstrap-daterangepicker'
  s.add_dependency 'rails-assets-chosen-sass-bootstrap'

  s.add_dependency 'coffee-rails'
  s.add_dependency 'jquery-rails'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara-webkit'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'launchy'
end
