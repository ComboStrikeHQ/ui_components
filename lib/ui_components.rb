Gem.loaded_specs['ui_components'].dependencies.each do |gem|
  require gem.name if gem.type == :runtime
end
require 'active_model/railtie'
require 'ui_components/engine'
require 'ui_components/cell'
require 'ui_components/form_helper'

require 'ui_components/test_utils' if %w(development test).include?(ENV['RAILS_ENV'])

ActionView::Base.send :include, UiComponents::FormHelper
