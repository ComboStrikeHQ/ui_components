# frozen_string_literal: true

RSpec.describe 'date_range', type: :helper do
  subject(:rendered) do
    Nokogiri::HTML.parse(date_range)
  end

  let(:form) do
    helper.bootstrap_form_for :foo, url: '/' do |f|
      return f
    end
  end

  context 'with label' do
    let(:date_range) { helper.ui_component('date_range', form: form, name: 'bar', label: 'Foo') }

    it 'renders a label' do
      expect(rendered.css('label')).to be_present
      expect(rendered.css('label').text).to eq('Foo')
    end
  end

  context 'without label' do
    let(:date_range) { helper.ui_component('date_range', form: form, name: 'bar') }

    it 'renders no label' do
      expect(rendered.css('label')).not_to be_present
      expect(rendered.css('label').text).not_to eq('Foo')
    end
  end
end
