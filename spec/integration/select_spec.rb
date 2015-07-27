RSpec.feature 'Select', :js do
  scenario 'is selectable' do
    visit '/select'

    ui_component_select('Arctic', from: 'Type')
    expect(page.find('.Select-placeholder').text).to eq('Arctic')
  end

  scenario 'loads data asynchronously' do
    visit '/select_async'

    ui_component_search('Type', 'Baa')
    expect(page).to have_content('Baar')
    expect(page).to have_content('Baaz')
    expect(page).to_not have_content('Fooo')
  end
end
