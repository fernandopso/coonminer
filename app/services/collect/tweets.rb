module Collect
  class Tweets
    include Collect::Client::TwitterService

    attr_accessor :token, :number_of_tweets_created

    def initialize(token)
      self.token = token
      self.number_of_tweets_created = 0
    end

    def call
      collect_tweets
      Rails.logger.info("Created #{number_of_tweets_created} tweets")
      token.update(collect_at: DateTime.current)
    end

    private

    def collect_tweets
      tweets(token.word, token.lang).each do |t|
        ActiveRecord::Base.connection_pool.with_connection do
          tweet = new_tweet(t)
          if tweet.save
            DocumentFrequency.new(tweet, token, t.user).call
          end
        end

        break if limit_max_tweeets_to_save?
      end
    end

    def new_tweet(t)
      tokenizer = Collect::Tokenizer.new(t)
      Tweet.new(
        token_id:        token.id,
        text:            t.text,
        url:             t.url,
        reply:           t.reply?,
        retweet:         t.retweet?,
        username:        t.user.screen_name,
        lang:            t.lang,
        geo:             t.geo.coordinates,
        location:        t.user.location,
        place:           t.place.full_name,
        publish_at:      t.created_at,
        bag_of_links:    tokenizer.bag_of_links,
        bag_of_words:    tokenizer.bag_of_words,
        bag_of_hashtags: tokenizer.bag_of_hashtags,
        bag_of_mentions: tokenizer.bag_of_mentions
      )
    end

    def limit_max_tweeets_to_save?
      self.number_of_tweets_created += 1
      number_of_tweets_created >= max_tweeets_to_save
    end

    def max_tweeets_to_save
      if token.enable
        CoonMiner.config.max_tweeets_to_save.paid
      else
        CoonMiner.config.max_tweeets_to_save.free
      end
    end
  end
end
