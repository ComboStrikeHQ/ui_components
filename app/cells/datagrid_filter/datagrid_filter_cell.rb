# frozen_string_literal: true

class DatagridFilterCell < FormCellBase
  attribute :form, mandatory: true, description: 'A form object.'
  attribute :filter, mandatory: true, description: 'A Datagrid filter object.'
  attribute :width, description: 'The width of the component.'

  def show
    case options[:filter].type
    when :enum
      ui_component(:select, select_options)
    when :string
      options[:form].search_field(name_option, label: header_option)
    else
      raise 'Filter not supported'
    end
  end

  private

  def header_option
    options[:filter].header
  end

  def name_option
    options[:filter].name
  end

  def select_options
    options.slice(:form, :width).merge(
      name: name_option,
      select_options: options[:filter].options[:select].call,
      label: header_option
    )
  end
end
