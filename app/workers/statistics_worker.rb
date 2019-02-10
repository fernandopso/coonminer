class StatisticsWorker
  include Sidekiq::Worker

  sidekiq_options retry: 0

  LOG_NAME = "StatisticsWorker >"

  def perform(token_id = nil)
    logger.info "#{LOG_NAME} start"

    if token_id
      logger.info "#{LOG_NAME} Find token by id #{token_id}"
      tokens = Token.where(id: token_id)
    else
      tokens = Token.active.cron_active.collect_at_desc.take(4)
    end

    tokens.each do |token|
      logger.info "#{LOG_NAME} Try StatisticsToken to #{token.word}"

      StatisticsToken.new(token).update

      logger.info token.statistics.as_json
    end

    logger.info "#{LOG_NAME} done"
  end
end
