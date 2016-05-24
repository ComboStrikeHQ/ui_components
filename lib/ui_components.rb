# frozen_string_literal: true
Gem.loaded_specs['ad2games-ui_components'].dependencies.each do |gem|
  # TODO: remove when cells-rails follows the gem convention to have a primary file
  if gem.name == 'cells-rails'
    require 'cells/rails'
    next
  end
  require gem.name if gem.runtime?
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
