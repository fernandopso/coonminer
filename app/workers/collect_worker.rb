# frozen_string_literal: true

class CollectWorker
  include Sidekiq::Worker

  sidekiq_options retry: 0

  def perform
    token = Token.active.cron_active.collect_at_asc.first

    logger.info "Try Collect::Tweets to #{token.word}"

    Collect::Tweets.new(token).call

    logger.info "Perform async StatisticsWorker to #{token.id}"

    StatisticsWorker.perform_async(token.id)

    logger.info "done to #{token.word}"
  end
end
