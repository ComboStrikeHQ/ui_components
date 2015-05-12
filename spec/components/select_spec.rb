RSpec.describe 'select', type: :helper do
  subject do
    Nokogiri::HTML.parse(select)
  end

  let(:form) do
    helper.bootstrap_form_for :foo, url: '/' do |f|
      return f
    end
  end

  let(:select) do
    helper.ui_component(:select, select_options.reverse_merge(form: form, width: '100%'))
  end
  let(:select_options) { {} }

  context 'with minimal required options' do
    let(:select_options) { { name: 'bar', options: [] } }

    it 'renders the label with the correct for attribute' do
      expect(subject.css('label').attr('for').to_s).to eq('foo_bar')
    end

    it 'renders the select with the correct id' do
      expect(subject.css('select').attr('id').to_s).to eq('foo_bar')
    end
  end

  context 'with a label provided' do
    let(:select_options) { { options: [], label: 'Game' } }

    it 'uses this label' do
      expect(subject.css('label').text).to eq('Game')
    end
  end

  context 'with an instance variable set' do
    let(:select_options) { { name: 'game_id', options: [['Commander Keen', 23]] } }

    it "pre-selects the instance's attribute's value" do
      assign(:foo, double('some object', game_id: 23))

      expect(subject.css('option[selected="selected"]').attr('value').to_s).to eq('23')
      expect(subject.css('option[selected="selected"]').text).to eq('Commander Keen')
    end
  end

  pending 'with a model instance provided to the form'
end
