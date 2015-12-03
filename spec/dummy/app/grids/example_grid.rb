class ExampleGrid
  include Datagrid

  def html_column_groups
    column_groups = html_columns.group_by do |column|
      column.options[:column_group]
    end
    return [] if column_groups.keys.compact.empty?

    column_groups.map do |column_group, columns|
      OpenStruct.new(
        name: column_group,
        columns: columns
      )
    end
  end

  scope do
    [
      { a: 1, b: 5 },
      { a: 2, b: 6 }
    ]
  end

  column(:col_1, column_group: 'A') do |element|
    element[:a]
  end

  column(:col_2, column_group: 'A') do |element|
    element[:a]
  end

  column(:col_3, column_group: 'B') do |element|
    element[:b]
  end

  column(:col_4, column_group: 'B') do |element|
    element[:b]
  end
end
