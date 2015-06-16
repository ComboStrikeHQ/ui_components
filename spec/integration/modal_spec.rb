RSpec.feature 'Modal', :js do
  scenario 'works' do
    visit '/modal'

    click_on('Show')

    expect(page).to have_content('It works!')

    click_on('×')

    expect(page).not_to have_content('It works!')
    expect(page).not_to have_css('.modal-footer')
  end

  scenario 'it can have a footer' do
    visit '/modal_with_footer'

    click_on('Show')

    expect(page).to have_css('.modal-footer')
    expect(page).to have_content('Some footer')
    expect(page).to have_css('u')
  end
end
