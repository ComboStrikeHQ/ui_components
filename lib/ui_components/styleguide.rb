module UiComponents
  class Styleguide
    def self.components
      Engine.components_paths.map(&:basename)
        .map { |c| (c.to_s.camelize + 'Cell').constantize }
    end
  end
end
