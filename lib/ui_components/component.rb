module UiComponents
  class Component
    attr_reader :component_options

    def initialize(options = {})
      @component_options = OpenStruct.new(options)
    end

    def self.by_name(name)
      "UiComponents::#{name.camelize}".constantize
      end
    end
  end
end
