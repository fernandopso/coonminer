module Filter
  class Tokens
    attr_accessor :tokens, :params

    def initialize(tokens, params)
      self.tokens = tokens
      self.params = params
    end

    def sort_tokens
      filter_tokens_by_cron
      filter_tokens_by_status
      filter_tweets_by_public
      filter_tweets_by_category
      filter_tweets_by_publish
      order_tokens
      tokens
    end

    private

    def filter_tokens_by_cron
      if params[:cron].present?
        if params[:cron] == "active"
          self.tokens = tokens.cron_active
        elsif params[:cron] == "disabled"
          self.tokens = tokens.cron_disabled
        end
      end
    end

    def filter_tokens_by_status
      if params[:status] == "disabled"
        self.tokens = tokens.disabled
      else
        self.tokens = tokens.active
      end
    end

    def filter_tweets_by_public
      if params[:public].present?
        if params[:public] == "disabled"
          self.tokens = tokens.privated
        elsif params[:public] == "active"
          self.tokens = tokens.publics
        end
      end
    end

    def filter_tweets_by_category
      if params[:category].present?
        self.tokens = tokens.send("category_#{params[:category]}")
      end
    end

    def filter_tweets_by_publish
      if params[:publish].present?
        if params[:publish] == "disabled"
          self.tokens = tokens.not_publishables
        elsif params[:publish] == "active"
          self.tokens = tokens.publishables
        end
      end
    end

    def order_tokens
      if params[:order].present?
        self.tokens = tokens.order("#{params[:order]} asc")
      else
        self.tokens = tokens.collect_at_desc
      end
    end
  end
end
