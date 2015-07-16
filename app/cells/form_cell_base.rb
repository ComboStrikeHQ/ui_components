class FormCellBase < UiComponents::Cell
  include ActionView::Helpers::FormOptionsHelper

  private

  def id
    [form.try(:object_name), options.fetch(:name)].compact.join('_').underscore
  end

  def name
    if form.try(:object_name).present?
      "#{form.object_name}[#{options.fetch(:name)}]".underscore
    else
      options.fetch(:name)
    end
  end

  def label
    options[:label]
  end

  def form
    options[:form]
  end

  def t(key)
    I18n.t("ui_components.#{self.class.to_s.underscore}.#{key}")
  end
end
