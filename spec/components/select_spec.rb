RSpec.describe 'select', type: :helper do
  subject do
    Nokogiri::HTML.parse(select)
  end

  let(:form) do
    helper.bootstrap_form_for :foo, url: '/' do |f|
      return f
    end
  end

  context 'with minimal required options' do
    let(:select) do
      helper.ui_component(:select, form: form, name: 'bar', options: [])
    end

    it 'renders the label with the correct for attribute' do
      expect(subject.css('label').attr('for').to_s).to eq('foo_bar')
    end

    it 'renders the select with the correct id' do
      expect(subject.css('select').attr('id').to_s).to eq('foo_bar')
    end

    it 'looks up the translation for the label using the name' do
      expect(controller).to receive(:t).with('.bar').and_return('Bar')

      expect(subject.css('label').text).to eq('Bar')
    end
  end

  context 'for an *_id attribute' do
    let(:select) do
      helper.ui_component(:select, form: form, name: 'bar_id', options: [])
    end

    it 'strips the _id suffix off the name when looking up translations' do
      expect(controller).to receive(:t).with('.bar').and_return('Bar')

      expect(subject.css('label').text).to eq('Bar')
    end
  end

  context 'with a label provided' do
    let(:select) do
      helper.ui_component(:select, form: form, name: 'bar', options: [], label: 'Game')
    end

    it 'uses this label' do
      expect(subject.css('label').text).to eq('Game')
    end
  end

  context 'with an instance variable set' do
    let(:select) do
      helper.ui_component(:select, form: form, name: 'game_id', options: [['Commander Keen', 23]])
    end

    it "pre-selects the instance's attribute's value" do
      assign(:foo, double('some object', game_id: 23))

      expect(subject.css('option[selected="selected"]').attr('value').to_s).to eq('23')
      expect(subject.css('option[selected="selected"]').text).to eq('Commander Keen')
    end
  end

  pending 'with a model instance provided to the form'
end
