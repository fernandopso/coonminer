module Collect
  class Tweets
    include Collect::Client::TwitterService

    attr_accessor :token

    def initialize(token)
      self.token = token
    end

    def call
      collect_tweets
      token.update(collect_at: DateTime.current)
    end

    private

    def collect_tweets
      tweets(token.word, token.lang).each do |t|
        CreateTweetWorker.perform_async(t, token.id)
      end
    end
  end
end
