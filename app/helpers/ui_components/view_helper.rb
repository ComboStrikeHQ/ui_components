module UiComponents
  module ViewHelper
    def ui_component(name, options = {})
      if Dir.exist?(File.expand_path("../../../components/#{name}", __FILE__))
        component_class = "UiComponents::#{name.camelize}Component".constantize
        render_component(name, component_class.new(options).properties)
      else
        cell(name.to_sym, nil, options).call(:show)
      end
    end
  end
end
