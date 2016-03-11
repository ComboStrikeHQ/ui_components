# frozen_string_literal: true
RSpec.feature 'Markdown readonly', :js do
  scenario 'is rendered' do
    visit '/markdown_readonly'

    expect(page).to have_css('h1')
    expect(find('h1').text).to eq('It works!')
  end
end
