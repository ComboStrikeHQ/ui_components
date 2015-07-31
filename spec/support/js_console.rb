module JsConsole
  def console_messages
    page.driver.phantomjs_logger.try(:rewind)
    page.driver.phantomjs_logger.try(:read).try(:split, "\n")
  end

  def clear_console_messages
    page.driver.phantomjs_logger.try(:reopen)
  end
end

RSpec.configure do |config|
  config.include JsConsole

  config.before(:example, :js) do
    clear_console_messages
  end
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new app, phantomjs_logger: StringIO.new, js_errors: false
end
