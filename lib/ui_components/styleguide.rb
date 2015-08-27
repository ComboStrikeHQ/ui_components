module UiComponents
  class Styleguide
    def self.components
      Engine.components_paths.map do |path|
        (path.basename.to_s.camelize + 'Cell').constantize
      end
    end
  end
end
