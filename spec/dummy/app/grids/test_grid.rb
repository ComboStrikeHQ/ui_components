# frozen_string_literal: true

require 'datagrid'

class TestGrid
  include Datagrid

  scope do
    [
      { a: 1, b: 5 },
      { a: 2, b: 6 }
    ]
  end

  filter(
    :string_attribute,
    :string,
    header: 'String Header'
  ) do |value, scope|
    scope.select { |row| row[:a] == value.to_i }
  end

  filter(
    :select_attribute,
    :enum,
    select: -> { [['a', 5], ['b', 6]] },
    header: 'B'
  ) do |value, scope|
    scope.select { |row| row[:b] == value }
  end

  column(:some_attribute, order: false) do |element, _grid|
    element[:b]
  end

  def self.validators_on(*)
    []
  end
end
