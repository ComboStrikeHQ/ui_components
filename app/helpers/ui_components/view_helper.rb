module UiComponents
  module ViewHelper
    def ui_component(name, options = {})
      if Dir.exist?(File.expand_path("../../../components/#{name}", __FILE__))
        render_component(name, options)
      else
        cell(name.to_sym, nil, options).call(:show)
      end
    end
  end
end
