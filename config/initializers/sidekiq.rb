# frozen_string_literal:true

# Heroku or Docker
redis_config = { url: ENV['REDIS_URL'] || ENV['DOCKER_REDIS'] }

if redis_config[:url].present?
  Sidekiq.configure_server do |config|
    config.redis = redis_config
  end

  Sidekiq.configure_client do |config|
    config.redis = redis_config
  end

  Sidekiq::Cron::Job.load_from_hash YAML.load_file('config/schedule.yml')
end