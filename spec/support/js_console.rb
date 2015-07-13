module JsConsole
  def console_messages
    page.driver.phantomjs_logger.rewind
    page.driver.phantomjs_logger.read.split("\n")
  end

  def clear_console_messages
    if defined?(page)
      page.driver.phantomjs_logger.rewind
    end
  end
end

RSpec.configure do |config|
  config.include JsConsole

  config.before do
    clear_console_messages
  end
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new app, phantomjs_logger: StringIO.new
end
