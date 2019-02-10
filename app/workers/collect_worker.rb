# frozen_string_literal: true

class CollectWorker
  include Sidekiq::Worker

  sidekiq_options retry: 0

  LOG_NAME = 'CollectWorker >'

  def perform
    logger.info "#{LOG_NAME} start"

    token = Token.active.cron_active.collect_at_asc.first

    logger.info "#{LOG_NAME} Try Collect::Tweets to #{token.word}"

    Collect::Tweets.new(token).call

    logger.info "#{LOG_NAME} Perform async StatisticsWorker to #{token.id}"

    StatisticsWorker.perform_async(token.id)

    logger.info "#{LOG_NAME} done to #{token.word}"
  end
end
