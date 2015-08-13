RSpec.describe 'select', type: :helper do
  subject do
    Nokogiri::HTML.parse(select)
  end

  let(:grid) { TestGrid.new }

  let(:form) do
    helper.bootstrap_form_for grid, url: '/' do |f|
      return f
    end
  end

  let(:select) do
    helper.datagrid_filters(form, grid.filters, width: '300px')
  end

  context 'with minimal required options' do
    it 'renders the label with the correct for attribute' do
      expect(subject.css('label').attr('for').to_s).to eq('test_grid_some_attribute')
    end

    it 'renders the select with the correct id' do
      expect(subject.css('select').attr('id').to_s).to eq('test_grid_some_attribute')
    end

    it 'renders the correct options' do
      expect(subject.css('option').map { |a| a.attr('value') }).to eq(['', '5', '6'])
      expect(subject.css('option').map(&:text)).to eq(['', 'a', 'b'])
    end
  end
end
