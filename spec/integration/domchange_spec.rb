RSpec.feature 'uic:domchange event', :js do
  scenario 'the DOM is ready' do
    visit '/domchange'

    # expect(page.driver.console_messages.map { |m| m[:message] })
    #   .to eq(['uic:domchange was fired'])
  end

  scenario 'a modal is shown' do
    visit '/domchange'

    page.execute_script(<<-JS)
      $(document).trigger('shown.bs.modal');
    JS

    # expect(page.driver.console_messages.map { |m| m[:message] })
    #   .to eq(['uic:domchange was fired', 'uic:domchange was fired'])
  end
end
