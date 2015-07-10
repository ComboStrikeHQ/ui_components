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
    helper.ui_component(
      :select, select_options.reverse_merge(form: form, name: 'species', width: '100%'))
  end

  let(:select_options) { {} }

  describe 'label magic' do
    context 'with a label param passed in' do
      let(:select_options) { { label: 'Fox species' } }

      it 'renders that label' do
        expect(subject.css('label').text).to eq('Fox species')
      end
    end

    context 'with no label passed in but a model on the form' do
      let(:model) { Fox.new(id: 1, species: 'Fennec') }

      let(:form) do
        helper.bootstrap_form_for model, url: '/' do |f|
          return f
        end
      end

      it 'renders uses the human attribute name' do
        expect(subject.css('label').text).to eq('Fox species')
      end
    end

    context 'with no label and no model around' do
      it 'humanizes the name param' do
        expect(subject.css('label').text).to eq('Species')
      end
    end
  end
end
