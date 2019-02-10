module Tokens
  class LinksController < ApplicationController
    before_action :require_admin, only: %(ban)

    before_action :set_token_for_public_user

    def index
      @links = Filter::Tweets.new(@token, params).links
    end

    def ban
      @token.links.find(params[:id]).ban
    end
  end
end
