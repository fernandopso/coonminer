module Tokens
  class LinksController < ApplicationController
    before_action :require_admin, only: :ban
    before_action :set_token_for_public_user, :set_links, only: :index
    before_action :set_chart_options

    def index
    end

    def ban
      @token.links.find(params[:id]).ban
    end

    private

    def set_links
      @links = Filter::Tweets.new(@token, params).links
    end

    def set_chart_options
      @chart_options = prepare_chart(options_for_chart)
    end

    def options_for_chart
      @links.pluck :href, :df
    end
  end
end
