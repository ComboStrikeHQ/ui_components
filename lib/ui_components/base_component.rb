module UiComponents
  class BaseComponent
    attr_reader :options

    def initialize(options)
      @options = options
    end

    def properties
      fail 'Not implemented'
    end
  end
end
