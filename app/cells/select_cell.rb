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
    opts = options
      .slice(:remote_options, :options, :multiple, :width)
      .merge(name: name, id: id, selected: selected)
    # Explicitly set default width here instead of doing it in CSS to prevent
    # chosen from automagically figuring out the wrong value.
    unless opts.key?(:width)
      opts[:width] = inline? ? 'auto' : '100%'
    end
    opts
  end

  def inline?
    form.layout == :inline
  end

  def errors
    form.object.try(:errors).try(:[], name_option.to_sym) || []
  end
end
