# vim: syntax=ruby

require 'thor/group'
require 'active_support/core_ext/string'

class GenerateComponent < Thor::Group
  include Thor::Actions

  argument :name, type: :string, desc: "The component's name."
  desc 'Create a new component.'
  source_root File.expand_path('../../ui_components/templates', __FILE__)

  def create_cell
    template 'cell.tt',
             "app/cells/#{name}/#{name}_cell.rb"
  end

  def create_view
    template 'view.tt',
             "app/cells/#{name}/#{name}.slim"
  end

  def create_config
    template 'config.tt',
             "app/cells/#{name}/#{name}.yml"
  end

  def create_assets
    template 'coffee.tt',
             "app/cells/#{name}/#{name}.coffee"
    template 'sass.tt',
             "app/cells/#{name}/#{name}.scss"
  end
end
