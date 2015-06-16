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

  scenario 'it loads remote content' do
    visit '/modal_with_remote_content'

    click_on('Show')

    expect(page).to have_content('Some title')
    expect(page).to have_content('It works remotely!')
  end

  scenario 'it fires a domchanged event after remote content was loaded' do
    visit '/modal_with_remote_content'

    page.execute_script(<<-JS)
      $(document).on('uic:domchange', function(e) {
        $(e.target).find('.modal-body').append('<h2>It still works remotely!');
      });
    JS

    click_on('Show')

    expect(page).to have_content('It still works remotely!')
  end
end
