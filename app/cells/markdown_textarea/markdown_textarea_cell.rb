# frozen_string_literal: true

class MarkdownTextareaCell < FormCellBase
  attribute :name, mandatory: true, description: "The textarea's name attribute."
  attribute :form, mandatory: true, description: 'A Rails form object.'
  attribute :value, description: "The textarea's content."
  attribute :rows, description: 'Number of rows.'
  attribute :label, description: 'A label for the form input.'

  private

  def textarea
    form.text_area options[:name], textarea_opts
  end

  def textarea_opts
    opts = {
      skip_label: true,
      rows: options[:rows] || 10,
      control_col: 'col-sm-12'.dup,
      label_col: '',
      data: { toggle: 'markdown', target: "##{preview_id}" }
    }

    opts[:value] = options[:value] if options[:value]

    opts
  end

  def form_group
    form.__send__(:form_group_builder, name, label: label) do
      # rubocop:disable Rails/OutputSafety
      yield.html_safe
    end
  end

  def preview_id
    "markdown_textarea_preview_#{name_param}"
  end

  def edit_id
    "markdown_textarea_edit_#{name_param}"
  end
end
