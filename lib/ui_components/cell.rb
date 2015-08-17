module UiComponents
  class Cell < ::Cell::ViewModel
    view_paths << "#{Engine.root}/app/cells"

    def initialize(*args)
      super
      options.except(:controller).each do |k, v|
        self.send(:"#{k}=", v)
      end
      validate_mandatory_arguments
    end

    def attributes
      self.class.attributes.keys.map do |k|
        [k, self.send(k)]
      end.to_h
    end

    def show
      render :show
    end

    class << self
      def attribute(name, options = {})
        options = ActionController::Parameters.new(options)
        attributes << {
          name: name,
          mandatory: options.require(:mandatory),
          description: options.require(:description),
          example: options.require(:example)
        }

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
        to_s.underscore.sub(/cell\Z/, '')
      end

      def example_attributes
        attributes.map { |p| p.slice(:name, :example).values }.to_h
      end
    end

    private

    def validate_mandatory_arguments
      missing_arguments = self.class.attributes
        .select { |a| a[:mandatory] && self.send(a[:name]).nil? }
      if missing_arguments.present?
        fail MandatoryPropertyNotSet,
             'Following mandatory arguments have not been provided: ' +
             missing_arguments.map { |m| m[:name] }.join(', ')
      end
    end

    class MandatoryPropertyNotSet < StandardError; end
  end
end
