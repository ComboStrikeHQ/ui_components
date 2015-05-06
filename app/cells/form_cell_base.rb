class FormCellBase < Cell::ViewModel
  include ActionView::Helpers::FormOptionsHelper

  private

  def label
    options[:label] if options.key?(:label)
    controller.t(".#{options[:name].sub(/_id/, '')}")
  end
end
