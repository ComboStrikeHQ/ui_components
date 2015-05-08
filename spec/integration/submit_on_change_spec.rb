RSpec.feature 'Submit on change form element', :js do
  scenario 'selecting a value submits the form' do
    visit '/submit_on_change'

    expect(page).to_not have_content('Success')

    select 'SomeOption', from: '[element]'
    expect(page).to have_content('Success')
  end
end
