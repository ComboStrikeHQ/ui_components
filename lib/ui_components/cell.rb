module UiComponents
  class Cell < ::Cell::ViewModel
    include DocuCop

    self.view_paths << Engine.root.join('app', 'cells')

    def show
      render self.class.component_name.to_sym
    end
  end
end
