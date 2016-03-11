# frozen_string_literal: true
class ModalCell < UiComponents::Cell
  attribute :id, mandatory: true, description: 'The HTML id attribute.'
  attribute :content, mandatory: true, description: "The modal's content."
  attribute :title, description: 'A title.'
  attribute :buttons, description: 'An array of button types. ' \
                                   'Valid types are `:close` and `:submit`.'

  private

  def buttons
    return unless @buttons
    @buttons.map do |button|
      case button
      when :close then close_button
      when :submit then submit_button
      else raise "'#{button}' button not implemented"
      end
    end.join
  end

  def close_button
    content_tag('button', class: 'btn btn-default', data: { dismiss: 'modal' }) do
      I18n.t('ui_components.modal.close')
    end
  end

  def submit_button
    submit_tag(I18n.t('ui_components.modal.save'), class: 'btn btn-primary')
  end
end
