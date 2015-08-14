module UiComponents
  class Engine < ::Rails::Engine
    MountainView.configure do |c|
      c.components_path = File.join(GEM_ROOT, 'app', 'components')
    end
  end
end
