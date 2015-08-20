module UiComponents
  class Engine < ::Rails::Engine
    initializer 'ui_components.assets.add_load_paths' do |app|
      app.config.assets.paths += self.class.components_paths
    end

    def self.components_paths
      Dir.glob(root.join('app', 'cells', '*'))
        .map { |path| Pathname.new(path) }
        .select { |path| Dir.exist?(path) }
    end
  end
end
