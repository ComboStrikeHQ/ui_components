Gem.loaded_specs['ui_components'].dependencies.each { |gem| require gem.name }
require 'ui_components/engine'

Cell::ViewModel.template_engine = 'slim'
