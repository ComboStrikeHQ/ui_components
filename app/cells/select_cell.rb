class SelectCell < FormCellBase
  def show
    options[:form].select(
      options[:name],
      select_options,
      { label: label, include_blank: true },
      html_options
    )
  end

  private

  def html_options
    html_opts = { class: css_class }
    html_opts.update(options.slice(:required, :multiple))
    html_opts[:data] = options.slice(:placeholder, :error, :width)
    html_opts
  end

  def select_options
    options[:options]
  end

  def options
    { width: '300px' }.merge(super)
  end

  def css_class
    classes = %w(form-control ui-components-select chosen)
    classes << 'chosen-inline' if options[:inline]
    classes.join(' ')
  end
end
