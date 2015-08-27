module UiComponents
  module DocuCop
    extend ActiveSupport::Concern

    class_methods do
      def component_name
        to_s.underscore.sub(/_cell\Z/, '')
      end

      def examples
        documentation[:examples].presence ||
          fail("No examples provided for #{component_name} component")
      end

      def description
        documentation[:description].presence ||
          fail("No description provided for '#{component_name}' component")
      end

      def documentation
        file = Engine.root.join('app', 'cells', component_name, "#{component_name}.yml")
        YAML.load(File.read(file)).deep_symbolize_keys
      end
    end
  end
end
