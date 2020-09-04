Guisso::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { :host => Settings.host }

  if Settings.smtp.present?
    smtp_settings = {}.tap do |settings|
      settings[:address]              = Settings.smtp["address"] if Settings.smtp["address"].present?
      settings[:port]                 = Settings.smtp["port"] if Settings.smtp["port"].present?
      settings[:domain]               = Settings.smtp["domain"] if Settings.smtp["domain"].present?
      settings[:user_name]            = Settings.smtp["user_name"] if Settings.smtp["user_name"].present?
      settings[:password]             = Settings.smtp["password"] if Settings.smtp["password"].present?
      settings[:authentication]       = Settings.smtp["authentication"] if Settings.smtp["authentication"].present?
      settings[:enable_starttls_auto] = Settings.smtp["enable_starttls_auto"] if Settings.smtp["enable_starttls_auto"].present?
    end
    if smtp_settings.present?
      config.action_mailer.delivery_method = :smtp
      config.action_mailer.smtp_settings = smtp_settings
    end
  end

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Generate digests for assets URLs.
  config.assets.digest = true
end
