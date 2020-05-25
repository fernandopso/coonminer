module Tokens
  class TweetsController < ApplicationController
    before_action :set_token_for_public_user
    before_action :set_charts

    def index
      @tweets = @token.tweets.send(rate_open).send(rate).publish_at_desc.paginate(page: params[:page], per_page: 50)
    end

    private

    def rate_open
      params['rate_open'].blank? ? 'all' : params['rate_open']
    end

    def rate
      params['rate'].blank? ? 'all' : params['rate']
    end

    def set_charts
      @user_positive = ['Positive', @token.metric.user_rated_positive, '#337ab7']
      @user_neutral  = ['Neutral',  @token.metric.user_rated_neutral, '#fcf8e3']
      @user_negative = ['Negative', @token.metric.user_rated_negative, '#a94442']

      @svm_positive = ['Positive', @token.metric.svm_rated_positive, '#337ab7']
      @svm_neutral  = ['Neutral',  @token.metric.svm_rated_neutral, '#fcf8e3']
      @svm_negative = ['Negative', @token.metric.svm_rated_negative, '#a94442']
    end
  end
end
