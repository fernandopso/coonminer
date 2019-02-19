class DocumentFrequency

  attr_accessor :tweet, :token, :user

  def initialize(tweet, token_id, user = nil)
    self.tweet = tweet
    self.token = Token.find(token_id)
    self.user = user
  end

  def call
    word_frequency
    mentions_frequency
    hashtags_frequency
    links_frequency
    profile_frequency
    languages_frequency
    location_frequency
  end

  private

  def word_frequency
    tweet.bag_of_words.each do |word|
      token.words.find_or_initialize_by(name: word).up_df
    end
  end

  def mentions_frequency
    tweet.bag_of_mentions.each do |mention|
      token.mentions.find_or_initialize_by(name: mention).up_df
    end
  end

  def hashtags_frequency
    tweet.bag_of_hashtags.each do |hashtag|
      token.hashtags.find_or_initialize_by(name: hashtag).up_df
    end
  end

  def links_frequency
    tweet.bag_of_links.each do |link|
      token.links.find_or_initialize_by(href: link).up_df if link.scan('twitter.com').empty?
    end
  end

  def profile_frequency
    if user
      profile = token.profiles.find_or_initialize_by(username: tweet.username)
      profile.image = user['profile_image_url']
      profile.profile_image = user['profile_banner_url'].to_s
      profile.profile_color = user['profile_link_color']
      profile.name = user['name']
      profile.tweets_count = user['statuses_count']
      profile.followers_count = user['followers_count']
      profile.following_count = user['friends_count']
      profile.up_df
    end
  end

  def languages_frequency
    token.languages.find_or_initialize_by(name: tweet.lang).up_df
  end

  def location_frequency
    if tweet.location.present?
      token.locations.find_or_initialize_by(name: tweet.location).up_df
    end
  end
end
