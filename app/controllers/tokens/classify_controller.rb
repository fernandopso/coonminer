module Tokens
  class ClassifyController < ApplicationController
    before_action :authenticate_user!
    before_action :set_token

    def index
      @tweets = @token.tweets.not_rated.publish_at_desc.paginate(page: params[:page], per_page: 30)
    end

    def update
      @tweet = @token.tweets.find(params[:id])
      @tweet.update(tweet_params)
      MetricToken.new(@token).update
    end

    private

    def tweet_params
      params.require(:tweet).permit(:rate)
    end
  end
end
