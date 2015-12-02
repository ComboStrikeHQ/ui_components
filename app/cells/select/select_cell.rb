class SelectCell < FormCellBase
  attribute :disabled, description: 'Whether or not the field is disabled.'
  attribute :form, mandatory: true, description: 'A form object.'
  attribute :name, mandatory: true, description: 'The name attribute.'
  attribute :select_options, description: 'Select options of the form `[[label, value]]`.'
  attribute :label, description: 'A label. If not provided it will be derived from `name`.'
  attribute :skip_label, description: 'Whether to not show the label.'
  attribute :required, description: 'Whether or not the field is required.'
  attribute :multiple, description: 'Enable multi-select behavior.'
  attribute :placeholder, description: 'A placeholder text.'
  attribute :error, description: 'An error message to display (E.g. on failed validations).'
  attribute :width, description: 'The width of the component.'
  attribute :remote_options, description: 'A URL path to load the options from.'
  attribute :inline, description: 'Whether or not the element should be rendered inline.'
  attribute :classes, description: 'CSS classes to be added to the element.'
  attribute :label_col, description: 'CSS col class applied to the label, defaults to `col-sm-2`'
  attribute :control_col,
    description: 'CSS col class applied to the control, defaults to `col-sm-10`'
  attribute :hide_label,
    description: 'Hide the label, but keep it accessible to screen readers (e.g. Capybara)'
  attribute :help, description: 'Help text associated with the control'

  def show
    options[:form].select(
      options[:name],
      select_options,
      control_options,
      html_options
    )
  end

  private

  def control_options
    options
      .slice(:label, :skip_label, :hide_label, :label_col, :control_col, :help)
      .merge(include_blank: true)
  end

  def html_options
    html_opts = { class: css_class }
    html_opts.update(options.slice(:required, :multiple, :disabled))
    html_opts[:data] = options.slice(:placeholder, :error, :width, :remote_options)
    html_opts[:data][:allow_single_deselect] = !options[:required]
    html_opts
  end

  def select_options
    options[:select_options] || []
  end

  def css_class
    classes = %w(form-control ui-components-select chosen)
    classes << 'chosen-inline' if options[:inline]
    classes << options[:classes] if options[:classes]
    classes.join(' ')
  end
end
