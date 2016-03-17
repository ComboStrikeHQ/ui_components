# frozen_string_literal: true
require_relative '../../app/helpers/ui_components/view_helper'

module UiComponents
  class Cell < ::Cell::ViewModel
    include UiComponents::ViewHelper
    include CellAttributes
    include DocuCop

    view_paths << Engine.root.join('app', 'cells')

    def show
      render(self.class.name.to_sym)
    end
  end
end
