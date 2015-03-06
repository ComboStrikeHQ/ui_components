module UiComponents
  class SubHeading < Component
    delegate :text, to: :component_options
  end
end
