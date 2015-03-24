module UiComponents
  class Select < Component
    include ActionView::Helpers::FormOptionsHelper 

    def select
      form.select(
        name,
        options_for_select(options),
        { label: label },
        data: {
          error: error,
          width: width || '300px',
        },
        required: required,
        class: css_class,
      )
    end

    def id
      name.gsub(/[^_\w]/, '_')
    end

    def label
      super or
        name.split(/[\[\]]/).select(&:present?).last.sub('_id\z', '').humanize
    end

    def css_class
      classes = %w(form-control ui-components-select chosen)
      classes << 'chosen-inline' if inline
      classes.join(' ')
    end
  end
end
