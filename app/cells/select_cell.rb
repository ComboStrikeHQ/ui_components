class SelectCell < FormCellBase
  include React::Rails::ViewHelper

  def show
    content_tag(:div, class: 'form-group') do
      label_tag(id, label, class: 'control-label col-sm-2') +
        react_component('ui_components.Select', react_options, class: 'col-sm-10')
    end
  end

  private

  def name
    return "#{super}[]" if options[:multiple]
    super
  end

  def label
    return options[:label] if options.key?(:label)
    form.object.try(:class).try(:human_attribute_name, name_option) || name_option.humanize
  end

  def selected
    form.object ? value_from_object : value_from_params
  end

  def value_from_params
    params[form.object_name].try(:[], name_option)
  end

  def value_from_object
    form.object.try(:send, name_option)
  end

  def name_option
    options.fetch(:name).to_s
  end

  def react_options
    options
      .slice(:remote_options, :options, :chosenOptions, :multiple)
      .merge(name: name, id: id, selected: selected)
  end
end
