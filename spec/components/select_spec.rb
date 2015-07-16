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
      :select, select_options.reverse_merge(form: form, name: 'species'))
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

    context 'with skip_label option' do
      let(:select) do
        options = select_options.reverse_merge(form: form, name: 'species', skip_label: true)
        helper.ui_component(:select, options)
      end

      it 'does not render the label' do
        expect(subject.css('label')).to be_empty
      end
    end
  end

  describe 'has error' do
    let(:erroneous_fox) do
      Fox.new.tap { |f| f.errors.add(:species, 'does not exist') }
    end

    let(:form) do
      helper.bootstrap_form_for erroneous_fox, url: '/' do |f|
        return f
      end
    end

    it 'adds has-error class to form group' do
      expect(subject.css('.form-group').attr('class').to_s).to eq('form-group has-error')
    end

    it 'displays the error' do
      expect(subject.css('span.help-block').text).to include('does not exist')
    end
  end

  describe 'classes option' do
    let(:select) do
      options = select_options.reverse_merge(form: form, name: 'species', classes: ['foo', 'bar'])
      helper.ui_component(:select, options)
    end

    it 'is passed on to chosen' do
      component = subject.css('[data-react-class="ui_components.Select"]').first
      props = JSON.parse(component['data-react-props'])
      expect(props['className']).to eq('foo bar')
    end
  end

  describe 'without a form' do
    let(:select) do
      helper.ui_component(:select, name: 'something')
    end

    it 'still works' do
      expect { subject }.to_not raise_error
    end
  end

  describe 'id prop' do
    context 'without id option provided' do
      let(:select) do
        helper.ui_component(:select, name: 'foo')
      end

      it 'uses the id option' do
        component = subject.css('[data-react-class="ui_components.Select"]').first
        props = JSON.parse(component['data-react-props'])
        expect(props['id']).to eq('foo')
      end
    end

    context 'with id option provided' do
      let(:select) do
        helper.ui_component(:select, name: 'foo', id: 'bar')
      end

      it 'uses the id option' do
        component = subject.css('[data-react-class="ui_components.Select"]').first
        props = JSON.parse(component['data-react-props'])
        expect(props['id']).to eq('bar')
      end
    end
  end
end
