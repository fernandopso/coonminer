module Tokens
  class MiningController < ApplicationController
    before_action :set_token_for_public_user, :sample_tweet_of_token, only: :index

    def index
    end

    def classify
      tweet_to_classify.update(params_to_classify)
    end

    private

    def params_to_classify
      { rate_open: rate, rate_open_by: user }
    end

    def tweet_to_classify
      Tweet.find_by_uuid(params[:id])
    end

    def sample_tweet_of_token
      @tweet = @token.tweets.where.not(uuid: nil).not_rated.not_reply.not_retweet.publish_at_desc.sample
    end

    def rate
      params[:tweet][:rate]
    end

    def user
      current_user ? current_user.email : request.remote_ip
    end
  end
end
