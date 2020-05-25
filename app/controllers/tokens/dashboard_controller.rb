module Tokens
  class DashboardController < ApplicationController
    before_action :set_token_for_public_user, only: :index

    def index
      @tweet = @token.tweets.not_rated_by_anyone.not_reply.not_retweet.publish_at_desc.sample
    end

    def classify
      tweet_classify.update(params_classify)

      redirect_to token_tweets_path(params[:token_id])
    end

    private

    def params_classify
      { rate_open: rate, rate_open_by: user }
    end

    def tweet_classify
      Tweet.find_by_uuid(params[:id])
    end

    def rate
      params[:tweet][:rate]
    end

    def user
      current_user ? current_user.email : request.remote_ip
    end
  end
end
