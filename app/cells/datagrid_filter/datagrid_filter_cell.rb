class DatagridFilterCell < FormCellBase
  attribute :form, mandatory: true, description: 'A form object.'
  attribute :filter, mandatory: true, description: 'A Datagrid filter object.'
  attribute :width, description: 'The width of the component.'

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
      select_options: options[:filter].options[:select].call,
      label: options[:filter].header
    )
  end
end
