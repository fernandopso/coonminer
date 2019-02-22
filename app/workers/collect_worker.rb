# frozen_string_literal: true

class CollectWorker
  include Sidekiq::Worker

  sidekiq_options retry: 0

  MAX_JOBS_TO_ENQUEUE = ENV['MAX_JOBS_TO_ENQUEUE'] || 1

  def perform
    token = Token.active.cron_active.collect_at_asc.first

    return unless token

    if Sidekiq::Stats.new.enqueued < MAX_JOBS_TO_ENQUEUE.to_i
      logger.info "Try Collect::Tweets to #{token.word}"

      Collect::Tweets.new(token).call

      logger.info "Perform async StatisticsWorker to #{token.id}"

      StatisticsWorker.perform_async(token.id)
    else
      logger.info 'Many jobs are enqueued and enqueue more can failed when allow memory on Redis'
    end

    logger.info "done to #{token.word}"
  end
end
