module UiComponents
  class Select < Component
    delegate :name, :error, :required, :options, to: :component_options

    def width
      component_options.width or '300px'
    end

    def label
      component_options.label or
        name.split(/[\[\]]/).select(&:present?).last.sub('_id\z', '').humanize
    end
  end
end
