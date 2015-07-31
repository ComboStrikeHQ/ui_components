require 'pry'
module UiComponents
  class Engine < ::Rails::Engine
    GEM_ROOT = Pathname.new(File.expand_path('../../..', __FILE__))

    initializer 'ui_components.assets.remove_from_load_paths' do |app|
      app.config.assets.paths.reject! do |path|
        [
          /rails-assets-react-\d/, # Already in react-rails gem
          /rails-assets-chosen-\d/ # Already in chosen-rails gem
        ].any? { |r| path.match(r) }
      end

      # Add the asset load path corresponding to the environment.
      env = ENV['RAILS_ENV']
      variant = %w(production staging).include?(env) ? 'production' : 'development'
      app.config.assets.paths << GEM_ROOT.join("app/assets/javascripts/#{variant}").to_s
    end
  end
end
