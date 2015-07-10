$LOAD_PATH.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name = 'ui_components'

  # PLEASE DO NOT CHANGE
  # We don't publish this gem to a gemserver but use git commit references instead.
  # There is no need for versioning on a gem level and changing this only creates more git noise.
  s.version = '1.0.0'

  s.authors = ['ad2games']
  s.email = ['developers@ad2games.com']
  s.homepage = 'http://www.ad2games.com'
  s.summary = 'ad2games UiComponents'
  s.license = 'MIT'

  s.files = Dir['{app,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '~> 4.2.0'
  s.add_dependency 'cells', '>= 4.0.0.beta2'
  s.add_dependency 'cells-slim', '>= 0.0.3'

  s.add_dependency 'slim-rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'compass-rails'
  s.add_dependency 'uglifier'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'turbolinks'

  s.add_dependency 'bootstrap-sass'
  s.add_dependency 'bootstrap_form'
  s.add_dependency 'rails_bootstrap_navbar'
  s.add_dependency 'bootstrap-datepicker-rails'
  s.add_dependency 'rails-assets-bootstrap-daterangepicker'
  s.add_dependency 'chosen-rails'
  s.add_dependency 'rails-assets-bootstrap-chosen'
  s.add_dependency 'rails-assets-chosen'
  s.add_dependency 'rails-assets-marked'
  s.add_dependency 'react-rails'
  s.add_dependency 'rails-assets-react-chosen'

  s.add_dependency 'jquery-turbolinks'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'underscore-rails'
  s.add_dependency 'rails-assets-jquery.floatThead'

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara-webkit'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'teaspoon-jasmine'
  s.add_development_dependency 'sqlite3'
end
