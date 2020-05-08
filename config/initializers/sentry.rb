if Rails.env.production? && ENV['COONMINER_SENTRY_DSN']
  Raven.configure do |config|
    config.dsn = ENV['COONMINER_SENTRY_DSN']
    config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  end
end
