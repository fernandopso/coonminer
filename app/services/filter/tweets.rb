module Filter
  class Tweets
    attr_accessor :token, :rate, :date, :lang, :page

    TOP_50 = 50

    def initialize(token, params)
      self.token = token
      self.date  = params[:date].present? ? params[:date].downcase : 'all'
      self.rate  = params[:rate].present? ? params[:rate].downcase : 'all'
      self.lang  = params[:lang].present? ? params[:lang].downcase : nil
      self.page  = params[:page].present? ? params[:page].downcase : 1
    end

    def hashtags
      token.hashtags.where(name: options_for(:bag_of_hashtags)).order_by_df_desc.limit(TOP_50)
    end

    def languages
      token.languages.where(name: options_for(:lang)).order_by_df_desc.limit(TOP_50)
    end

    def locations
      token.locations.where(name: options_for(:location)).order_by_df_desc.limit(TOP_50)
    end

    def mentions
      token.mentions.where(name: options_for(:bag_of_mentions)).order_by_df_desc.limit(TOP_50)
    end

    def links
      token.links.where(href: options_for(:bag_of_links)).order_by_df_desc.paginate(page: page, per_page: 50)
    end

    def profiles
      token.profiles.where(username: options_for(:username)).order_by_df_desc.paginate(page: page, per_page: 50)
    end

    private

    # TODO: Fix it
    def options_for(type)
      if lang
        token.tweets.where_language(lang).send(date).send(rate).pluck(type).flatten.compact.uniq
      else
        token.tweets                     .send(date).send(rate).pluck(type).flatten.compact.uniq
      end
    end
  end
end
