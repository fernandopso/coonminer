module Tokens
  class MentionsController < ApplicationController
    before_action :set_token_for_public_user
    before_action :set_mentions
    before_action :set_chart_options

    def index
    end

    private

    def set_mentions
      @mentions = Filter::Tweets.new(@token, params).mentions
    end

    def set_chart_options
      @chart_options = prepare_chart(options_for_chart)
    end

    def options_for_chart
      @mentions.pluck :name, :df
    end
  end
end
