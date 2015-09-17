RSpec.feature 'Modal component', :js do
  before do
    visit '/'
  end

  scenario 'a simple modal is triggered' do
    within(all('.modal_component .component')[0]) do
      expect(page).to_not have_content('Hello!')
      click_on('Click me!')
      expect(page).to have_content('Hello!')
      expect(page).to_not have_css('.modal-footer')
    end
  end

  scenario 'a modal with buttons is triggered' do
    within(all('.modal_component .component')[1]) do
      expect(page).to_not have_content('Hello!')
      click_on('Click me!')
      expect(page).to have_content('Hello!')
      expect(page).to have_button('Close')
      expect(page).to have_button('Save')
      click_on('Close')
      expect(page).to_not have_content('Hello!')
    end
  end
end
