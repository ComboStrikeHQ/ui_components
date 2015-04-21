Gem.loaded_specs['ui_components'].dependencies.each { |gem| require gem.name }
require 'active_model/railtie'
require 'ui_components/engine'
require 'ui_components/form_helper'

Cell::ViewModel.template_engine = 'slim'

ActionView::Base.send :include, UiComponents::FormHelper
