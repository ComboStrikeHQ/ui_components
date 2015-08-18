module UiComponents
  module DocuCop
    extend ActiveSupport::Concern

    def initialize(*args)
      super
      return if UiComponents::Styleguide::EXCLUDED_COMPONENTS.include?(self.class)
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
        .select { |a| a[:mandatory] && send(a[:name]).nil? }
      return unless missing_arguments.present?
      fail MandatoryPropertyNotSet,
        'Following mandatory arguments have not been provided: ' +
          missing_arguments.map { |m| m[:name] }.join(', ')
    end

    class MandatoryPropertyNotSet < StandardError; end

    class_methods do
      def attribute(name, options = {})
        options = ActionController::Parameters.new(options)
        attributes << {
          name: name,
          mandatory: options.require(:mandatory),
          description: attribute_description(name)
        }
        define_accessors(name)
      end

      def define_accessors(name)
        define_method(name) do
          instance_variable_get(:"@#{name}")
        end

        define_method(:"#{name}=") do |value|
          instance_variable_set(:"@#{name}", value)
        end
      end

      def attributes
        @attributes ||= []
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
