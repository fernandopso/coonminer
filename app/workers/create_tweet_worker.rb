# frozen_string_literal: true

class CreateTweetWorker
  include Sidekiq::Worker

  sidekiq_options retry: 5

  def perform(tweet_from_twitter, tweet_url, token_id)
    create(tweet_from_twitter, tweet_url, token_id) if can_save?(token_id)
  end

  private

  def create(tweet_from_twitter, tweet_url, token_id)
    ActiveRecord::Base.connection_pool.with_connection do
      tweet = new_tweet(tweet_from_twitter, tweet_url, token_id)

      Rails.logger.info("Build #{tweet} to token_id: #{token_id}")

      DocumentFrequency
        .new(tweet, token_id, tweet_from_twitter['user'])
        .call if tweet.save
    end
  end

  def new_tweet(tweet_from_twitter, tweet_url, token_id)
    tokenizer = Collect::Tokenizer.new(tweet_from_twitter)
    geo = tweet_from_twitter['geo']['coordinates'] if tweet_from_twitter['geo']
    place = tweet_from_twitter['place']['full_name'] if tweet_from_twitter['place']

    Tweet.new(
      token_id:        token_id,
      text:            tweet_from_twitter['text'],
      url:             tweet_url,
      reply:           !tweet_from_twitter['in_reply_to_user_id'].nil?,
      retweet:         tweet_from_twitter['retweeted'],
      username:        tweet_from_twitter['user']['screen_name'],
      lang:            tweet_from_twitter['lang'],
      geo:             geo,
      location:        tweet_from_twitter['user']['location'],
      place:           place,
      publish_at:      tweet_from_twitter['created_at'],
      bag_of_links:    tokenizer.bag_of_links,
      bag_of_words:    tokenizer.bag_of_words,
      bag_of_hashtags: tokenizer.bag_of_hashtags,
      bag_of_mentions: tokenizer.bag_of_mentions
    )
  end

  def can_save?(token_id)
    token = Token.find(token_id)

    return true if token.enable

    token.tweets.count < max_tweets_to_save
  end

  def max_tweets_to_save
    CoonMiner.config.max_tweets_to_save.free
  end
end
