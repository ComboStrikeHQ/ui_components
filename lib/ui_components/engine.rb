# frozen_string_literal: true
module UiComponents
  class Engine < ::Rails::Engine
    initializer 'ui_components.assets.add_load_paths' do |app|
      app.config.assets.paths += self.class.components_paths
      app.config.assets.paths << root.join('vendor/assets/bower_components')
      app.config.assets.paths << root.join('app', 'assets', 'fonts')
    end

    initializer 'ui_components.assets.precompile' do |app|
      app.config.assets.precompile += %w(styleguide.js
                                         styleguide.css)
      app.config.assets.precompile +=
        self.class.components_paths
          .map(&:basename)
          .map { |p| ["#{p}.js", "#{p}.css"] }
          .flatten

      app.config.assets.precompile += %w(chosen/chosen-sprite.png
                                         chosen/chosen-sprite@2x.png)
    end

    def self.components_paths
      Dir[root.join('app/cells/*/')].map { |path| Pathname.new(path) }
    end
  end
end
