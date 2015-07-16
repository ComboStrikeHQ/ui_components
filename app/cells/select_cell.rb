class SelectCell < FormCellBase
  include React::Rails::ViewHelper

  def show
    render :show
  end

  private

  def name
    return "#{super}[]" if options[:multiple]
    super
  end

  def label
    return options[:label] if options.key?(:label)
    form_object.try(:class).try(:human_attribute_name, name_option) || name_option.humanize
  end

  def selected
    form_object ? value_from_object : value_from_params
  end

  def value_from_params
    params[form.try(:object_name)].try(:[], name_option)
  end

  def value_from_object
    form_object.try(:send, name_option)
  end

  def name_option
    options.fetch(:name).to_s
  end

  def react_options
    opts = options
      .slice(:remote_options, :options, :multiple, :width)
      .merge(name: name, id: id, selected: selected, class_name: class_name)
    # Explicitly set default width here instead of doing it in CSS to prevent
    # chosen from automagically figuring out the wrong value.
    unless opts.key?(:width)
      opts[:width] = inline? ? 'auto' : '100%'
    end
    opts.transform_keys { |k| k.to_s.camelize(:lower) }
  end

  def inline?
    form.try(:layout) == :inline
  end

  def errors
    form_object.try(:errors).try(:[], name_option.to_sym) || []
  end

  def class_name
    Array.wrap(options[:classes]).join(' ')
  end

  def form_object
    form.try(:object)
  end
end
