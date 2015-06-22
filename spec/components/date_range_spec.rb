RSpec.describe 'date_range', type: :helper do
  subject do
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
      expect(subject.css('label')).to be_present
      expect(subject.css('label').text).to eq('Foo')
    end
  end

  context 'without label' do
    let(:date_range) { helper.ui_component('date_range', form: form, name: 'bar') }

    it 'renders no label' do
      expect(subject.css('label')).to_not be_present
      expect(subject.css('label').text).to_not eq('Foo')
    end
  end
end
