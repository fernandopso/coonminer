module Tokens
  class UsersController < ApplicationController
    before_action :set_token_for_public_user

    def index
      @users = Filter::Tweets.new(@token, params).profiles
    end
  end
end
