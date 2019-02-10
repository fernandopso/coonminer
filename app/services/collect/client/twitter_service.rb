# frozen_string_literal: true

module Collect
  module Client
    module TwitterService
      def tweets(word, lang)
        if filter_lang?(lang)
          client.search("#{word} -rt", lang: lang, result_type: 'mixed').take(max_tweeets_to_collect)
        else
          client.search("#{word} -rt", result_type: 'mixed').take(max_tweeets_to_collect)
        end
      end

      private

      def client
        CoonMiner.twitter_client
      end

      def filter_lang?(lang)
        lang != 'all'
      end

      def max_tweeets_to_collect
        CoonMiner.config.max_tweets_to_collect
      end
    end
  end
end
