RSpec.feature 'Select', :js do
  scenario 'is selectable' do
    visit '/'

    chosen_select('Arctic', from: 'Type')
  end
end
