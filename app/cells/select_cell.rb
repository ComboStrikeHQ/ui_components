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
    if form.object
      value_from_object
    else
      value_from_params
    end
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

  def html_options
    html_opts = { class: css_class }
    html_opts.update(options.slice(:required, :multiple))
    html_opts[:data] = options.slice(:placeholder, :error, :width, :remote_options)
    html_opts
  end

  def react_options
    options
      .slice(:remote_options, :options, :chosenOptions, :multiple)
      .merge(name: name, id: id, selected: selected)
  end

  def options
    unless super[:width]
      warn 'DEPRECATED: UiComponents here, you did not provide a :width option' \
        ' to the select component. The default value of "300px" still applies,' \
        ' but will be dropped at some point in the future in favor of' \
        ' bootstrap\'s default. Provide a :width option to make this warning go' \
        ' away.'
    end

    { width: '300px' }.merge(super)
  end

  def css_class
    classes = %w(form-control ui-components-select chosen)
    classes << 'chosen-inline' if options[:inline]
    classes << options[:classes] if options[:classes]
    classes.join(' ')
  end
end
