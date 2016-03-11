# frozen_string_literal: true
class HelloWorldCell < UiComponents::Cell
  attribute :name, mandatory: true, description: 'A name.'
end
