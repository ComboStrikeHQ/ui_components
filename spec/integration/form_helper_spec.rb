RSpec.feature 'Form helper', :js do
  scenario 'renders a form with fields populated from params' do
    visit '/form_helper?fox[answer]=42'

    expect(find_field('Answer').value).to eq('42')
  end
end
