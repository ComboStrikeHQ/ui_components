module UiComponents
  module DocuCop
    extend ActiveSupport::Concern

    def initialize(*args)
      super
      return if Styleguide::EXCLUDED_COMPONENTS.include?(self.class.to_s)
      self.class.attributes.keys.each { |attr_name| self.class.define_accessors(attr_name) }
      options.except(:controller).each do |k, v|
        send(:"#{k}=", v)
      end
      validate_mandatory_attributes
    end

    def attributes
      self.class.attributes.keys.map do |k|
        [k, send(k)]
      end.to_h
    end

    private

    def validate_mandatory_attributes
      missing_arguments = self.class.attributes
        .select { |name, config| config[:mandatory] && send(name).nil? }
      return unless missing_arguments.present?
      fail MandatoryPropertyNotSet,
        'Following mandatory arguments have not been provided ' +
          "in an example for the #{self.class.component_name} component: " +
          missing_arguments.keys.join(', ')
    end

    class MandatoryPropertyNotSet < StandardError; end

    class_methods do
      def attributes
        @attributes ||= documentation[:attributes]
      end

      def define_accessors(name)
        define_method(name) do
          instance_variable_get(:"@#{name}")
        end

        define_method(:"#{name}=") do |value|
          instance_variable_set(:"@#{name}", value)
        end
      end

      def component_name
        to_s.underscore.sub(/_cell\Z/, '')
      end

      def examples
        documentation[:examples].presence ||
          fail("No examples provided for #{component_name} component")
      end

      def attribute_description(attribute)
        description = documentation
          .try(:[], :attributes)
          .try(:[], attribute.to_sym)
          .try(:[], :description)
        description.presence ||
          fail("Key 'attributes.#{attribute}.description' missing from #{component_name}.yml")
      end

      def documentation
        file = Engine.root.join('app', 'cells', component_name, "#{component_name}.yml")
        YAML.load(File.read(file)).deep_symbolize_keys
      end
    end
  end
end
