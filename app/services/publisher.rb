class Publisher

  MAX_TEXT_TO_TWEET = 100

  attr_accessor :client, :token, :hashtags, :locations, :languages, :links, :percent_total

  def initialize(token)
    self.client = CoonMiner.twitter_client
    self.token = token
    self.percent_total = token.tweets.last_24_hours.count
  end

  def hashtag
    sort_hashtags
    if hashtags.any?
      Rails.env.production? ? client.update(title_for_hashstags) : puts(title_for_hashstags)
    end
    update_publish_at
  end

  def location
    sort_locations
    if locations.any?
      Rails.env.production? ? client.update(title_for_locations) : puts(title_for_locations)
    end
    update_publish_at
  end

  def language
    if token.lang == "all"
      sort_languages
      if languages.any?
        Rails.env.production? ? client.update(title_for_languages) : puts(title_for_languages)
      end
    else
      puts "Language filter seted for #{token.word}"
    end
    update_publish_at
  end

  def link
    sort_links
    if links.any?
      Rails.env.production? ? client.update(title_for_links) : puts(title_for_links)
    end
    update_publish_at
  end

  private

  def update_publish_at
    token.update(publish_at: DateTime.current)
  end

  def title_for_hashstags
    I18n.t("publisher.hashtag_html", word: token.word, hashtags: parser(hashtags), uuid: token.uuid)
  end

  def title_for_locations
    I18n.t("publisher.location_html", word: token.word, locations: parser(locations), uuid: token.uuid)
  end

  def title_for_languages
    I18n.t("publisher.language_html", word: token.word, languages: parser(languages), uuid: token.uuid)
  end

  def title_for_links
    I18n.t("publisher.link_html", word: token.word, title: links[1]["title"][0..69], links: links[0], uuid: token.uuid)
  end

  def parser(items, n = 5)
    title = items.take(n).map.with_index(1){|(h, df), i| "#{i}º #{h}"}.join("\n")
    if title.split("").count + token.word.size > MAX_TEXT_TO_TWEET
      parser(items, n - 1)
    else
      title
    end
  end

  def percent(df)
    ActiveSupport::NumberHelper.number_to_currency(((df * 100 ).to_f / percent_total), precision: 1, unit: "")
  end

  def sort_hashtags
    self.hashtags = Array.new
    self.hashtags = token.tweets.last_24_hours.pluck(:hashtag).compact
    self.hashtags = sort_by_df(hashtags.map{ |key| [key, hashtags.count(key)] if key })
  end

  def sort_locations
    self.locations = Array.new
    self.locations = token.tweets.last_24_hours.pluck(:location).compact
    self.locations = sort_by_df(locations.map{ |key| [key, locations.count(key)] })
  end

  def sort_languages
    self.languages = Array.new
    self.languages = token.tweets.last_24_hours.pluck(:lang).compact
    self.languages = sort_by_df(languages.map{ |key| [I18n.t("languages.#{key}"), languages.count(key)] })
  end

  def sort_by_df(items)
    items.uniq.sort_by{ |k, v| v }.reverse
  end

  def sort_links
    token.bag_of_word.sort_links.each do |link_bag|
      if ["null", "error", "", "banned"].exclude?(link_bag[1]["title"]) && link_bag[1]["publish_at"].nil?
        self.links = link_bag
        break
      end
    end
    set_link_published
  end

  def set_link_published
    links[1]["publish_at"] = DateTime.current
    token.bag_of_word.links[links[0]] = links[1]
    token.bag_of_word.save
  end

end
