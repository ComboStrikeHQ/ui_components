RSpec.feature 'Loading of assets', :js do
  scenario 'does happen' do
    visit '/'

    expect(page).to have_content('UI Components')
    expect(page.driver.console_messages.map { |msg| msg[:message] })
      .to include('Welcome to UIComponents!')
  end
end
