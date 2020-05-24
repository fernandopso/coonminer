module Collect
  class Tweets
    include Collect::Client::TwitterService

    attr_accessor :token

    def initialize(token)
      self.token = token
    end

    def call
      collect_tweets
    end

    private

    def collect_tweets
      tweets(token.word, token.lang).each do |t|
        CreateTweetWorker.perform_async(t.as_json, t.url.to_s, token.id)
      end

      Rails.logger.info "Perform async MetricWorker to #{token.id}"

      MetricWorker.perform_async(token.id)
    end
  end
end
