RSpec.feature 'Modal component', :js do
  scenario 'a simple modal is triggered' do
    visit '/components/modal/0'

    expect(page).to_not have_content('Hello!')
    click_on('Click me!')
    expect(page).to have_content('Hello!')
    expect(page).to_not have_css('.modal-footer')
  end

  scenario 'a modal with buttons is triggered' do
    visit '/components/modal/1'

    expect(page).to_not have_content('Hello!')
    click_on('Click me!')
    expect(page).to have_content('Hello!')
    expect(page).to have_button('Close')
    expect(page).to have_button('Save')
    click_on('Close')
    expect(page).to_not have_content('Hello!')
  end
end
