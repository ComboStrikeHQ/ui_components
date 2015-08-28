Gem.loaded_specs['ui_components'].dependencies.each do |gem|
  require gem.name if gem.type == :runtime
end
require 'active_model/railtie'
require 'ui_components/engine'
require 'ui_components/cell_attributes'
require 'ui_components/docu_cop'
require 'ui_components/cell'
require 'ui_components/form_helper'
require UiComponents::Engine.root.join('app', 'cells', 'form_cell_base')
Dir.glob(UiComponents::Engine.root.join('app', 'cells', '*', '*.rb')).each { |c| require c }

ActionView::Base.include UiComponents::FormHelper
