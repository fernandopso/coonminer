# frozen_string_literal: true

class SampleWorker
  include Sidekiq::Worker

  sidekiq_options retry: 5

  def perform(token_id)
    if token_id
      token = Token.find(token_id)

      logger.info "Try Collect::Tweets to #{token.word}"

      token.collecting!

      Collect::Tweets.new(token).call

      logger.info "Perform async StatisticsWorker to #{token.id}"

      StatisticsWorker.perform_async(token.id)

      token.collected!

      logger.info "done to #{token.word}"
    else
      logger.info "no token_id provide"
    end
  end
end
