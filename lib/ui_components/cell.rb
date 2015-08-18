module UiComponents
  class Cell < ::Cell::ViewModel
    include DocuCop

    view_paths << "#{Engine.root}/app/cells"

    def show
      render :show
    end
  end
end
