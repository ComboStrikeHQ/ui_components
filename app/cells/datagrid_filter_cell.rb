class DatagridFilterCell < FormCellBase
  include UiComponents::ViewHelper

  def show
    case options[:filter].type
    when :enum
      ui_component(:select, select_options)
    else
      fail 'Filter not supported'
    end
  end

  private

  def select_options
    options.slice(:form, :width).merge(
      name: options[:filter].name,
      options: options[:filter].options[:select].call,
      label: options[:filter].header
    )
  end
end
