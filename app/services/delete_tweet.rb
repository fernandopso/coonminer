class DeleteTweet
  attr_accessor :tweet, :bag_of_word

  def initialize(tweet, bag_of_word)
    self.tweet = tweet
    self.bag_of_word = bag_of_word
  end

  def process(save_bag_of_words = true)
    word_frequency
    link_frequency
    user_frequency
    language_frequency
    location_frequency

    if save_bag_of_words
      bag_of_word.save
    end
  end

  private

  def simple_bag(bag)
    {
      "df" => bag["df"].to_i - 1,
      "updated_at" => I18n.l(DateTime.current, format: :ymd)
    }
  end

  def word_frequency
    tweet.tokens.each do |word|
      if word.present? and word.scan("http").empty?
        if word[0] == "@"
          if word != "@"
            if bag_of_word.mentions[word].present? and bag_of_word.mentions[word]["df"].to_i > 1
              bag_of_word.mentions[word] = simple_bag(bag_of_word.mentions[word])
            else
              bag_of_word.mentions.delete(word)
            end
          end
        elsif word[0] == "#"
          if word != "#"
            if bag_of_word.hashtags[word].present? and bag_of_word.hashtags[word]["df"].to_i > 1
              bag_of_word.hashtags[word] = simple_bag(bag_of_word.hashtags[word])
            else
              bag_of_word.hashtags.delete(word)
            end
          end
        else
          if bag_of_word.words[word].to_i > 1
            bag_of_word.words[word] = bag_of_word.words[word].to_i - 1
          else
            bag_of_word.words.delete(word)
          end
        end
      end
    end
  end

  def link_frequency
    if bag_of_word.links[tweet.href].present?
      if bag_of_word.links[tweet.href]["df"].to_i > 1
        bag_of_word.links[tweet.href]["df"] = bag_of_word.links[tweet.href]["df"].to_i - 1
        bag_of_word.links[tweet.href]["updated_at"] = I18n.l(DateTime.current, format: :ymd)
        if bag_of_word.links[tweet.href]["uuid"].nil?
          bag_of_word.links[tweet.href]["uuid"] = SecureRandom.uuid
        end
      else
        bag_of_word.links.delete(tweet.href)
      end
    end
  end

  def user_frequency
    if bag_of_word.users[tweet.username].present?
      if bag_of_word.users[tweet.username]["df"] > 1
        bag_of_word.users[tweet.username]["df"] = bag_of_word.users[tweet.username]["df"].to_i - 1
      else
        bag_of_word.users.delete(tweet.username)
      end
    end
  end

  def language_frequency
    if bag_of_word.langs[tweet.lang].present? and bag_of_word.langs[tweet.lang]["df"].to_i > 1
      bag_of_word.langs[tweet.lang] = simple_bag(bag_of_word.langs[tweet.lang])
    else
      bag_of_word.langs.delete(tweet.lang)
    end
  end

  def location_frequency
    if bag_of_word.locations[tweet.location].present? and bag_of_word.locations[tweet.location]["df"].to_i > 1
      bag_of_word.locations[tweet.location] = simple_bag(bag_of_word.locations[tweet.location])
    else
      bag_of_word.locations.delete(tweet.location)
    end
  end

end
