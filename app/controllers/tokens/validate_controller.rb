module Tokens
  class ValidateController < ApplicationController
    before_action :authenticate_user!
    before_action :set_token
    before_action :set_tweets

    def index
      if params[:rate].present?
        @tweets = @tweets.where(rate_svm: params[:rate]).paginate(page: params[:page])
      else
        @tweets = @tweets.paginate(page: params[:page])
      end
    end

    def update
      @tweet = @token.tweets.find(params[:id])
      @tweet.update(tweet_params)
      StatisticsToken.new(@token).update
    end

    private

    def set_tweets
      @tweets = @token.tweets.svm_rated.not_rated.publish_at_desc
    end

    def tweet_params
      params.require(:tweet).permit(:rate, :svm_rate_validate)
    end

  end
end
