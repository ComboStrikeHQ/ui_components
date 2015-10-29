RSpec.feature 'Select', :js do
  it 'allows deselecting a selected option' do
    expect(page).to_not have_content('Bar')
    visit '/components/select/0'
    chosen_select('Bar', from: 'Foo')
    expect(page).to have_content('Bar')
    find('.search-choice-close').click
    expect(page).to_not have_content('Bar')
  end
end
