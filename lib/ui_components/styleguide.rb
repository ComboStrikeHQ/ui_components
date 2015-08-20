module UiComponents
  class Styleguide
    def self.components
      #Engine.components_paths.map { |path| (path.basename.to_s.camelize + 'Cell').constantize }
      [HelloWorldCell, MarkdownReadonlyCell]
    end
  end
end
