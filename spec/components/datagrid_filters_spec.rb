# frozen_string_literal: true
RSpec.describe 'datagrid filters', type: :helper do
  subject(:rendered) do
    Nokogiri::HTML.parse(filter)
  end

  let(:grid) { TestGrid.new }

  let(:form) do
    helper.bootstrap_form_for grid, url: '/' do |f|
      return f
    end
  end

  let(:filter) do
    helper.datagrid_filters(form, grid.filters, width: '300px')
  end

  context 'with minimal required options' do
    it 'renders the labels with the correct for attribute and in the correct order' do
      expect(rendered.css('label').map { |l| l.attr('for').to_s }).to eq(
        %w(test_grid_string_attribute test_grid_select_attribute)
      )
    end

    it 'renders the select with the correct id' do
      expect(rendered.css('select').attr('id').to_s).to eq('test_grid_select_attribute')
    end

    it 'renders the string field with the correct id and input type' do
      expect(rendered.css('input').attr('id').to_s).to eq('test_grid_string_attribute')
      expect(rendered.css('input').attr('type').to_s).to eq('search')
    end

    it 'renders the correct options' do
      expect(rendered.css('option').map { |a| a.attr('value') }).to eq(['', '5', '6'])
      expect(rendered.css('option').map(&:text)).to eq(['', 'a', 'b'])
    end
  end
end
