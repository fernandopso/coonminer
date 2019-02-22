# frozen_string_literal: true

module Crawlers
  module Tokens
    class CollectTweetsWorker
      include Sidekiq::Worker

      sidekiq_options retry: 0

      MAX_JOBS_TO_ENQUEUE = ENV['MAX_JOBS_TO_ENQUEUE'] || 1

      def perform
        return unless token

        if Sidekiq::Stats.new.enqueued < MAX_JOBS_TO_ENQUEUE.to_i
          logger.info "Collect::Tweets to #{token.word}"

          token.update(collect_at: DateTime.current)

          Collect::Tweets.new(token).call
        else
          logger.info 'Many jobs enqueued'
        end

        logger.info "done to #{token.word}"
      end

      private

      def token
        @token ||= Token.active.cron_active.collect_at_asc.first
      end
    end
  end
end
