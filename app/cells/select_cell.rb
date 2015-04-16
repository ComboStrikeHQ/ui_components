class SelectCell < FormCellBase
  def show
    model.select(
      options[:name],
      options_for_select(select_options),
      { label: label },
      data: {
        error: options[:error],
        width: options[:width] || '300px'
      },
      required: options[:required],
      class: css_class
    )
  end

  private

  def select_options
    # TODO
    options[:options]
  end

  def css_class
    classes = %w(form-control ui-components-select chosen)
    classes << 'chosen-inline' if options[:inline]
    classes.join(' ')
  end
end
