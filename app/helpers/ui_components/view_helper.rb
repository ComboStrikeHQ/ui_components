module UiComponents
  module ViewHelper
    def ui_component(id, locals = {})
      render "ui_components/#{id}", locals
    end
  end
end
