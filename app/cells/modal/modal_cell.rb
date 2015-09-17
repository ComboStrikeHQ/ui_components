class ModalCell < UiComponents::Cell
  attribute :id, mandatory: true, description: 'The HTML id attribute.'
  attribute :content, mandatory: true, description: "The modal's content."
  attribute :title, description: 'A title.'
  attribute :buttons, description: 'An array of button types. Valid types are `:close` and `:save`.'

  private

  def buttons
    @buttons.try(:map) do |button|
      case button
      when :close
        content_tag('button', type: 'button', class: 'btn btn-default', data: { dismiss: 'modal' }) do
          'Close'
        end
      when :submit
        tag('input', type: 'submit', class: 'btn btn-primary', value: 'Save')
      end
    end.try(:join)
  end
end
