module UiComponents
  module CellAttributes
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
      return if missing_attributes.empty?
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
        attr_accessor name
      end

      def attributes
        @attributes ||= []
      end
    end
  end
end
