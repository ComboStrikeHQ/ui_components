module UiComponents
  class Engine < ::Rails::Engine
    ENGINE_ROOT = File.expand_path('../../..', __FILE__)
    MountainView.configure do |c|
      c.components_path = File.join(ENGINE_ROOT, 'app', 'components')
    end
  end
end
