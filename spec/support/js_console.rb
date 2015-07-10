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
