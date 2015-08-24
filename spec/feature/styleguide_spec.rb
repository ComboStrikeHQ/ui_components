RSpec.feature 'Styleguide', :js do
  scenario 'all components are properly documented' do
    visit '/styleguide'

    expect(page.status_code).to eq(200)
    expect(page).to have_css('h1', text: 'Hello, John!')
    expect(page).to have_content('A basic example.')
  end
end
