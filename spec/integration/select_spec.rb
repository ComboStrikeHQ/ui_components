RSpec.feature 'Select', :js do
  scenario 'is selectable' do
    visit '/select'

    ui_component_select('Arctic', from: 'Type')
    expect(page.find('.Select-placeholder').text).to eq('Arctic')
  end

  scenario 'loads data asynchronously' do
    visit '/select_async'

    ui_component_select('Baa', from: 'Type')

    expect(page.find('.Select-placeholder')).to have_content('Baar')
    expect(page).to_not have_content('Baaz')
    expect(page).to_not have_content('Fooo')
  end

  scenario 'multi-selects' do
    visit '/multiselect'

    ui_component_select('Arctic', from: 'Type')
    ui_component_select('Fennec', from: 'Type')
    expect(page.find('.Select-control').text).to eq('×Arctic×Fennec×')
  end
end
