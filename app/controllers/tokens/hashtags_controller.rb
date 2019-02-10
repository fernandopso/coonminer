module Tokens
  class HashtagsController < ApplicationController
    before_action :set_token_for_public_user
    before_action :set_hashtags
    before_action :set_chart_options

    def index
    end

    private

    def set_hashtags
      @hashtags = Filter::Tweets.new(@token, params).hashtags
    end

    def set_chart_options
      @chart_options = prepare_chart(options_for_chart)
    end

    def options_for_chart
      @hashtags.pluck :name, :df
    end
  end
end
