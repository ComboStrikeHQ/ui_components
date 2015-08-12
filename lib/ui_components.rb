Gem.loaded_specs['ui_components'].dependencies.each do |gem|
  require gem.name if gem.type == :runtime
end
require 'active_model/railtie'
require 'mountain_view'
require 'ui_components/engine'
require 'ui_components/cell'
require 'ui_components/form_helper'

ActionView::Base.send :include, UiComponents::FormHelper
