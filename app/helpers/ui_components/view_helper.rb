# frozen_string_literal: true

module UiComponents
  module ViewHelper
    def ui_component(name, options = {})
      cell(name.to_sym, nil, options).call(:show)
    end
  end
end
