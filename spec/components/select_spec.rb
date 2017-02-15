# frozen_string_literal: true
RSpec.describe 'select', type: :helper do
  subject(:rendered) do
    Nokogiri::HTML.parse(select)
  end

  let(:form) do
    helper.bootstrap_form_for :foo, url: '/' do |f|
      return f
    end
  end

  let(:select) do
    helper.ui_component(:select, select_options.reverse_merge(form: form, name: 'bar'))
  end
  let(:select_options) { {} }

  context 'with minimal required options' do
    let(:select_options) { { select_options: [] } }

    it 'renders the label with the correct for attribute' do
      expect(rendered.css('label').attr('for').to_s).to eq('foo_bar')
    end

    it 'renders the select with the correct id' do
      expect(rendered.css('select').attr('id').to_s).to eq('foo_bar')
    end
  end

  context 'with a label provided' do
    let(:select_options) { { select_options: [], label: 'Game' } }

    it 'uses this label' do
      expect(rendered.css('label').text).to eq('Game')
    end
  end

  context 'with additional classes' do
    let(:select_options) { { select_options: [], classes: %w(some classes) } }

    it 'adds the classes' do
      expect(rendered.css('select').first.attributes['class'].value).to include('some classes')
    end
  end

  context 'disabling select box' do
    context 'when disabled' do
      let(:select_options) { { select_options: [], disabled: true } }

      it 'disables the select box' do
        expect(rendered.css('select').attribute('disabled')).to be_present
      end
    end

    context 'when explicitly enabled' do
      let(:select_options) { { select_options: [], disabled: false } }

      it 'enables the select box' do
        expect(rendered.css('select').attribute('disabled')).to be_nil
      end
    end

    context 'default behavior' do
      let(:select_options) { { select_options: [] } }

      it 'enables the select box' do
        expect(rendered.css('select').attribute('disabled')).to be_nil
      end
    end
  end

  context 'skipping the label' do
    let(:select_options) { { select_options: [], skip_label: true } }

    it 'skips the label' do
      expect(rendered.css('label')).to be_empty
    end
  end

  context 'hiding the label' do
    let(:select_options) { { select_options: [], hide_label: true } }

    it 'skips the label' do
      expect(rendered.css('label.sr-only')).to be_present
    end
  end

  context 'with an instance variable set' do
    let(:select_options) { { name: 'game_id', select_options: [['Commander Keen', 23]] } }

    it "pre-selects the instance's attribute's value" do
      assign(:foo, OpenStruct.new(game_id: 23))

      expect(rendered.css('option[selected="selected"]').attr('value').to_s).to eq('23')
      expect(rendered.css('option[selected="selected"]').text).to eq('Commander Keen')
    end
  end

  context 'with label_col and control_col options provided' do
    let(:form) do
      helper.bootstrap_form_for :foo, url: '/', layout: :horizontal do |f|
        return f
      end
    end

    let(:select_options) do
      { label_col: 'col-sm-1', control_col: 'col-sm-11' }
    end

    it 'sets the respective classes' do
      expect(rendered.css('.form-group > label.col-sm-1')).to be_present
      expect(rendered.css('.form-group > div.col-sm-11')).to be_present
    end
  end

  context 'with help text option provided' do
    let(:select_options) { { help: 'Foo Bar' } }

    it 'adds help block' do
      expect(rendered.css('.form-group > span.help-block').text).to eq('Foo Bar')
    end
  end

  pending 'with a model instance provided to the form'
end
