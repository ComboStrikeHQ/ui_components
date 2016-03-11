# frozen_string_literal: true
RSpec.feature 'Styleguide', :js do
  scenario 'all components are properly documented' do
    # If any component is missing a description or an example, we get an
    # error.

    visit '/'

    expect(page.status_code).to eq(200)
    expect(page).to have_css('h1', text: 'Hello, John!')
    expect(page).to have_content('A basic example.')
  end
end
