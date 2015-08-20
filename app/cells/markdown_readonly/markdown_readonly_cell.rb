class MarkdownReadonlyCell < UiComponents::Cell
  attribute :content, mandatory: true,
                      description: 'Markdown text',
                      example: "# Heading\nSome text."
end
