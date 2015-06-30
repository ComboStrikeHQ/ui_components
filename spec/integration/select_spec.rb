RSpec.feature 'Select', :js do
  scenario 'is selectable' do
    visit '/select'

    chosen_select('Arctic', from: 'Type')
  end

  scenario 'loads data asynchronously' do
    visit '/select_async'

    chosen_search('Type', 'Baa')
    expect(page).to have_content('Baar')
    expect(page).to have_content('Baaz')
    expect(page).to_not have_content('Fooo')
  end
end
