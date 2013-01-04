KillBills::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Cache store
  config.cache_store = :dalli_store

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled
  config.consider_all_requests_local = false

  # Caching turned on
  config.action_controller.perform_caching = true

  # Enable Rails's static asset server (don't if Apache or nginx already do this)
  config.serve_static_assets = true

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Specify the default JavaScript compressor
  config.assets.js_compressor  = :uglifier

  # Specifies the header that your server uses for sending files
  # (comment out if your front-end server doesn't support this)
  config.action_dispatch.x_sendfile_header = "X-Sendfile" # Use 'X-Accel-Redirect' for nginx

  # Use Rack Cache with Dalli
  # https://devcenter.heroku.com/articles/rack-cache-memcached-static-assets-rails31
  config.action_dispatch.rack_cache = {
    metastore:    Dalli::Client.new,
    entitystore:  'file:tmp/cache/rack/body',
    allow_reload: false
  }

  # Rack Cache will know that static files should stay in cache forever
  config.static_cache_control = "public, max-age=2592000"

  # Add a hash digest in the static assets file names
  config.assets.digest = true

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :dalli_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w( search.js )

  # SMTP Settings
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              "smtp.gmail.com",
    port:                 587,
    domain:               ENV['GMAIL_SMTP_USER'],
    user_name:            ENV['GMAIL_SMTP_USER'],
    password:             ENV['GMAIL_SMTP_PASSWORD'],
    authentication:       'plain',
    enable_starttls_auto: true
  }

  config.action_mailer.default_url_options = { host: 'killbills.me' }

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # ExceptionNotifier
  config.middleware.use ExceptionNotifier,
    :email_prefix => "[KillBills] ",
    :sender_address => %{"Kill Bills" <killbillsapp@gmail.com>},
    :exception_recipients => %w{killbillsapp@gmail.com}
end

