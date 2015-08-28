module UiComponents
  class Engine < ::Rails::Engine
    initializer 'ui_components.assets.add_load_paths' do |app|
      app.config.assets.paths += self.class.components_paths
    end

    initializer 'ui_components.assets.precompile' do |app|
      app.config.assets.precompile += %w(styleguide.js
                                         styleguide.css)
    end

    def self.components_paths
      Dir[root.join('app/cells/*/')]
        .map { |path| Pathname.new(path) }
    end
  end
end
