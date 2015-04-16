class FormCellBase < Cell::ViewModel
  include ActionView::Helpers::FormOptionsHelper

  private

  def label
    options[:label] || controller.t(".#{options[:name]}")
  end
end
