RSpec.feature 'Select', :js do
  it 'allows deselecting a selected option for optional fields' do
    visit '/components/select/0'
    expect(page).to_not have_content('Bar')
    chosen_select('Bar', from: 'Foo')
    expect(page).to have_content('Bar')
    find('.search-choice-close').click
    expect(page).to_not have_content('Bar')
  end

  it 'does not allow deselecting single options if the field is required' do
    visit '/components/select/1'
    expect(page).to_not have_content('Bar')
    chosen_select('Bar', from: 'Foo')
    expect(page).to have_content('Bar')
    expect(page).to_not have_css('.search-choice-close')
  end
end
