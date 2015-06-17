module UiComponents
  module ViewHelper
    def ui_component(name, options = {})
      cell(name.to_sym, nil, options).call
    end
  end
end
