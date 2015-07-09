class FormCellBase < UiComponents::Cell
  include ActionView::Helpers::FormOptionsHelper

  private

  def id
    "#{form.object_name}_#{options.fetch(:name)}".underscore
  end

  def name
    if form.object_name.present?
      "#{form.object_name}[#{options.fetch(:name)}]".underscore
    else
      options.fetch(:name)
    end
  end

  def label
    options[:label]
  end

  def form
    options.fetch(:form)
  end

  def t(key)
    I18n.t("ui_components.#{self.class.to_s.underscore}.#{key}")
  end
end
