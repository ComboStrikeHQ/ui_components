module UiComponents
  module TestUtils
    def ui_component_select(what, opts = {})
      opts.deep_transform_keys! { |k| k.to_s.camelize(:lower) }
      page.execute_script("ui_components.TestUtils.select.apply(this, #{[what, opts].to_json})")
      find('.Select-item, .Select-placeholder', text: what)
    end

    def ui_component_trigger(event, selector)
      page.execute_script(<<-JS)
        _.map($('#{selector}'), _.partial(ui_components.TestUtils.trigger, '#{event}'));
      JS
    end

    def ui_component_select_value(name)
      css = "[name=\"#{name}\"]"
      find(css, visible: false).value
    end
  end
end
