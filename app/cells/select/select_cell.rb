class SelectCell < FormCellBase
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

  def show
    options[:form].select(
      options[:name],
      select_options,
      {
        label: label,
        include_blank: true,
        skip_label: options.fetch(:skip_label, false)
      },
      html_options
    )
  end

  private

  def html_options
    html_opts = { class: css_class }
    html_opts.update(options.slice(:required, :multiple))
    html_opts[:data] = options.slice(:placeholder, :error, :width, :remote_options)
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
