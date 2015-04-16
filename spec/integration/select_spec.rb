RSpec.feature 'Select', :js do
  scenario 'is selectable' do
    visit '/select'

    chosen_select('Arctic', from: 'Type')
  end
end
