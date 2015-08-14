require 'pry'
Gem.loaded_specs['ui_components'].dependencies.each do |gem|
  require gem.name if gem.type == :runtime
end
require 'active_model/railtie'
require 'mountain_view'

module UiComponents
  GEM_ROOT = File.expand_path('../..', __FILE__)
end

require 'ui_components/engine'
require 'ui_components/cell'
require 'ui_components/form_helper'
require 'ui_components/base_component'
Dir.glob(File.join(UiComponents::GEM_ROOT, 'app', 'components', '*', '*.rb')).each do |c|
  require c
end

ActionView::Base.send :include, UiComponents::FormHelper
