# frozen_string_literal: true

RSpec.feature 'Select', :js do
  it 'allows deselecting a selected option for optional fields' do
    visit '/components/select/0'
    expect(page).not_to have_content('Bar')
    chosen_select('Bar', from: 'Foo')
    expect(page).to have_content('Bar')
    find('.search-choice-close').click
    expect(page).not_to have_content('Bar')
  end

  it 'does not allow deselecting single options if the field is required' do
    visit '/components/select/1'
    expect(page).not_to have_content('Bar')
    chosen_select('Bar', from: 'Foo')
    expect(page).to have_content('Bar')
    expect(page).not_to have_css('.search-choice-close')
  end
end
