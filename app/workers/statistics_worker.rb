class StatisticsWorker
  include Sidekiq::Worker

  sidekiq_options retry: 0

  def perform(token_id = nil)
    if token_id
      logger.info "Find token by id #{token_id}"
      tokens = Token.where(id: token_id)
    else
      tokens = Token.active.cron_active.collect_at_desc.take(4)
    end

    tokens.each do |token|
      logger.info "Try StatisticsToken to #{token.word}"

      StatisticsToken.new(token).update

      logger.info token.statistics.as_json
    end

    logger.info "done"
  end
end
