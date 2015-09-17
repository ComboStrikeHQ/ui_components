class ModalCell < UiComponents::Cell
  attribute :id, mandatory: true, description: 'The HTML id attribute.'
  attribute :content, mandatory: true, description: "The modal's content."
  attribute :title, description: 'A title.'
  attribute :buttons, description: 'An array of button types. Valid types are `:close` and `:save`.'

  private

  def buttons
    @buttons.try(:map) do |button|
      case button
      when :close then close_button
      when :submit then submit_button
      else fail "'#{button}' button not implemented"
      end
    end.try(:join)
  end

  def close_button
    content_tag('button', class: 'btn btn-default', data: { dismiss: 'modal' }) do
      I18n.t('ui_components.modal.close')
    end
  end

  def submit_button
    tag('input', type: 'submit',
                 class: 'btn btn-primary',
                 value: I18n.t('ui_components.modal.save'))
  end
end
