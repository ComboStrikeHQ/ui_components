module UiComponents
  module TestUtils
    %i(select search).each do |method|
      define_method("ui_component_#{method}") do |*args|
        args.each do |arg|
          arg.deep_transform_keys! { |k| k.to_s.camelize(:lower) } if arg.is_a?(Hash)
        end
        page.execute_script("ui_components.TestUtils.#{method}.apply(this, #{args.to_json})")
      end
    end

    def ui_component_select_value(name)
      find("[name=\"#{name}\"]").value
    end
  end
end
