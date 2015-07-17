class MarkdownTextareaCell < FormCellBase
  def show
    render :show
  end

  private

  def textarea
    form.text_area options[:name], textarea_opts
  end

  def textarea_opts
    opts = {
      skip_label: true,
      rows: options[:rows] || 10,
      control_col: 'col-sm-12',
      label_col: '',
      data: { toggle: 'markdown', target: "##{preview_id}" }
    }

    opts.merge!(value: options[:value]) if options[:value]

    opts
  end

  def form_group
    form.send(:form_group_builder, name, label: label) do
      yield.html_safe
    end
  end

  def preview_id
    "markdown_textarea_preview_#{id}"
  end

  def edit_id
    "markdown_textarea_edit_#{id}"
  end
end
