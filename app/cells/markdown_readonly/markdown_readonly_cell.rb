# frozen_string_literal: true
class MarkdownReadonlyCell < UiComponents::Cell
  attribute :content, mandatory: true, description: 'Markdown text.'
end
