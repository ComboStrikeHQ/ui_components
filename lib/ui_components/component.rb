module UiComponents
  class Component < OpenStruct
    def self.by_name(name)
      "UiComponents::#{name.camelize}".constantize
    end
  end
end
