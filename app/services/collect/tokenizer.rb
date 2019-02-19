module Collect
  class Tokenizer
    attr_accessor :tweet, :text, :words

    def initialize(tweet)
      self.tweet = tweet
      self.text  = I18n.transliterate(tweet['text']).downcase
      self.words = text.split if remove_special_characters
    end

    def bag_of_words
      words.select { |word| valid_word?(word) }
    end

    def bag_of_hashtags
      tweet['entities']['hashtags'].map { |h| '#' + h['text'].downcase }
    end

    def bag_of_mentions
      tweet['entities']['user_mentions'].map { |m| '@' + m['screen_name'].downcase }
    end

    def bag_of_links
      tweet['entities']['urls'].map { |url| check_url(url['expanded_url']) }.compact
    end

    private

    def valid_word?(word)
      %w[# @].exclude?(word.first) && word[0..3] != 'http' && %w[-].exclude?(word)
    end

    def check_url(url)
      url if url.present? && url.scan('twitter.com').empty?
    end

    def remove_special_characters
      Constants::MARKS.each do |sc|
        self.text = text.gsub(sc, " ")
      end
    end
  end
end
