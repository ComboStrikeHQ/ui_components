# frozen_string_literal: true
RSpec.feature 'uic:domchange event', :js do
  scenario 'the DOM is ready' do
    visit '/domchange'

    expect(JS_LOGGER.string).to eq("uic:domchange was fired\n")
  end

  scenario 'a modal is shown' do
    visit '/domchange'

    page.execute_script(<<-JS)
      $(document).trigger('shown.bs.modal');
    JS

    expect(JS_LOGGER.string).to eq("uic:domchange was fired\nuic:domchange was fired\n")
  end
end
