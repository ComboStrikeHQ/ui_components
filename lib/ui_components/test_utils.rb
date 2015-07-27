module UiComponents
  module TestUtils
    %i(select search).each do |method|
      define_method("ui_component_#{method}") do |*args|
        page.execute_script("ui_components.TestUtils.#{method}.apply(this, #{args.to_json})")
      end
    end
  end
end
