module Tokens
  class LanguagesController < ApplicationController
    before_action :set_token_for_public_user
    before_action :set_languages
    before_action :set_chart_options

    def index
    end

    private

    def set_languages
      @languages = Filter::Tweets.new(@token, params).languages
    end

    def set_chart_options
      @chart_options = prepare_chart(options_for_chart)
    end

    def options_for_chart
      @languages.map{ |l| [l.human_name, l.df] if l.human_name }.compact
    end
  end
end
