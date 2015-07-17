module UiComponents
  class Engine < ::Rails::Engine
    initializer 'ui_components.assets.remove_from_load_paths' do |app|
      app.config.assets.paths.reject! do |path|
        path.match(/rails-assets-react-\d/) # Already in react-rails gem
      end
    end
  end
end
