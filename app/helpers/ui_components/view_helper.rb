module UiComponents
  module ViewHelper
    def ui_component(name, options = {})
      component = Component.by_name(name).new(options)
      render "ui_components/#{name}", component: component
    end
  end
end
