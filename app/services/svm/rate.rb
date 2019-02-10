require 'liblinear'

module Svm
  class Rate
    MIN_TWEETS_RATED = 25
    MAX_TWEETS_TO_RATE = 25

    attr_accessor :token, :tweets_rated, :tweets_to_rate

    def initialize(token)
      self.token          = token
      self.tweets_rated   = token.tweets.user_rated
      self.tweets_to_rate = token.tweets.not_rated.take(MAX_TWEETS_TO_RATE)
    end

    def process
      if can_rate?
        Svm::TfIdf.new(token, tweets_rated).process
        Svm::TfIdf.new(token, tweets_to_rate).process
        rate_tweets
        update_svm_rated_at
        tweets_to_rate.count
      end
    end

    def can_rate?
      tweets_rated.count >= MIN_TWEETS_RATED
    end

    private

    def rate_tweets
      tweets_to_rate.each do |tweet|
        rate_svm = Liblinear.predict(model, tweet.tf_idfs.map { |tf_idf| tf_idf.to_f })
        tweet.update(rate_svm: adapter_rate(rate_svm))
        puts "Tweet: #{tweet.text}", "Rated: #{adapter_rate(rate_svm)}"
      end
    end

    def model
      @model ||= Liblinear.train(
        { solver_type: Liblinear::L2R_LR },
        tweets_rated.map(&:rate_to_i),
        tweets_rated.map { |t| t.tf_idfs.map { |tf_idf| tf_idf.to_f } }
      )
    end

    def update_svm_rated_at
      token.update(svm_rated_at: DateTime.current)
    end

    def adapter_rate(option)
      case option
      when 1.0
        Tweet::POSITIVE
      when 0.0
        Tweet::NEUTRAL
      when -1.0
        Tweet::NEGATIVE
      end
    end
  end
end
