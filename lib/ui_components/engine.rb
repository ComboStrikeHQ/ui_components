module UiComponents
  class Engine < ::Rails::Engine
    config.react.variant = if defined?(Rails)
                             Rails.env
                           elsif ENV['RAILS_ENV']
                             ENV['RAILS_ENV']
                           else
                             :development
                           end
  end
end
