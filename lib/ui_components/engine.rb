module UiComponents
  class Engine < ::Rails::Engine
    initializer 'ui_components.assets.remove_from_load_paths' do |app|
      app.config.assets.paths.reject! do |path|
        [
          /rails-assets-react-\d/, # Already in react-rails gem
          /rails-assets-chosen-\d/ # Already in chosen-rails gem
        ].any? { |r| path.match(r) }
      end
    end
  end
end
