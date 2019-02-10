# frozen_string_literal: true

class SampleWorker
  include Sidekiq::Worker

  sidekiq_options retry: 1

  LOG_NAME = 'SampleWorker >'

  def perform(token_id)
    logger.info "#{LOG_NAME} start"

    if token_id
      token = Token.find(token_id)

      logger.info "#{LOG_NAME} Try Collect::Tweets to #{token.word}"

      token.collecting!

      Collect::Tweets.new(token).call

      logger.info "#{LOG_NAME} Perform async StatisticsWorker to #{token.id}"

      StatisticsWorker.perform_async(token.id)

      token.collected!

      logger.info "#{LOG_NAME} done to #{token.word}"
    else
      logger.info "#{LOG_NAME} no token_id provide"
    end
  end
end
