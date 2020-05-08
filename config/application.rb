require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CoonMiner
  class << self
    def twitter_client
      @twitter_client ||= twitter_with_credentials
    end

    def config
      @config ||= RecursiveOpenStruct.new(load_yaml('application')[Rails.env])
    end

    private

    def load_yaml(config)
      YAML.load_file("#{Rails.root}/config/#{config}.yml")
    end

    def twitter_with_credentials
      Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['COONMINER_CONSUMER_KEY']
        config.consumer_secret     = ENV['COONMINER_CONSUMER_SECRET']
        config.access_token        = ENV['COONMINER_ACCESS_TOKEN']
        config.access_token_secret = ENV['COONMINER_ACCESS_TOKEN_SECRET']
      end
    end
  end

  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
