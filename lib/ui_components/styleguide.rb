module UiComponents
  class Styleguide
    # TODO: Implement cells and remove from here.
    EXCLUDED_COMPONENTS = %w(ToolbarCell SelectCell)

    def self.components
      Engine.components_paths.map(&:basename)
        .map { |c| (c.to_s.camelize + 'Cell') }
        .reject { |c| EXCLUDED_COMPONENTS.include?(c) }
        .map(&:constantize)
    end
  end
end
