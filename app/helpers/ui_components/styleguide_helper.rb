module UiComponents::StyleguideHelper
  def ui_component_example_call(name, attributes)
    formatted_attributes = JSON.pretty_generate(attributes).gsub(/"([^"]+)":/, '\1:')
    "ui_component('#{name}', #{formatted_attributes})"
  end
end
