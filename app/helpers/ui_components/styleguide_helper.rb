module UiComponents::StyleguideHelper
  def ui_component_example_call(name, example)
    if example.keys.first == :attributes
      formatted_attributes = JSON.pretty_generate(example[:attributes]).gsub(/"([^"]+)":/, '\1:')
      "ui_component('#{name}', #{formatted_attributes})"
    else
      example.values.first
    end
  end

  def ui_component_execute_example_call(name, example)
    case example.keys.first
    when :attributes then
      eval ui_component_example_call(name, example) # rubocop:disable Lint/Eval
    when :slim then
      Slim::Template.new { example.values.last }.render(self).html_safe
    else
      fail "Not sure what to do with '#{example.keys.first}' kind of example"
    end
  end
end
