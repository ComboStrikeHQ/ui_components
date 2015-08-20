module UiComponents
  class Styleguide
    def self.components
      component_paths =
        Dir.glob(File.join(File.expand_path('../../../app/cells/', __FILE__), '*', '*.rb'))
      component_class_names = component_paths.map do |p|
        Pathname.new(p).basename.to_s.sub(/.rb\Z/, '').camelize
      end

      component_classes = component_class_names
        .select { |name| name.ends_with?('Cell') }
        .map(&:constantize)

      component_classes
    end
  end
end
