module UiComponents
  class Styleguide
    def self.components
      Engine.components_paths.map do |path|
        path.basename.to_s.camelize + 'Cell'
      end.sort.map(&:constantize)
    end
  end
end
