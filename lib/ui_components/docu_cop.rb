module UiComponents
  module DocuCop
    extend ActiveSupport::Concern

    def initialize(*args)
      super
      options.except(:controller).each do |k, v|
        public_send(:"#{k}=", v)
      end
      validate_mandatory_attributes
    end

    def attributes
      self.class.attributes.keys.map do |k|
        [k, public_send(k)]
      end.to_h
    end

    private

    def validate_mandatory_attributes
      missing_attributes = self.class.attributes
        .select { |a| a[:mandatory] && public_send(a[:name]).nil? }
      return unless missing_attributes.present?
      fail MandatoryAttributeNotSet,
        'Following mandatory attribute(s) have not been provided: ' +
          missing_attributes.map { |m| m[:name] }.join(', ')
    end

    class MandatoryAttributeNotSet < StandardError; end

    class_methods do
      def attribute(name, options = {})
        options = ActionController::Parameters.new(options)
        attributes << {
          name: name,
          mandatory: options[:mandatory] == true,
          description: options.require(:description)
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
