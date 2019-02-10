module Tokens
  class TweetsController < ApplicationController
    before_action :set_token_for_public_user
    before_action :set_charts

    def index
      @tweets = @token.tweets.send(user_rate).send(svm_rate).publish_at_desc.paginate(page: params[:page], per_page: 50)
    end

    private

    def user_rate
      params['rate_user'].blank? ? 'all' : params['rate_user']
    end

    def svm_rate
      params['rate_svm'].blank? ? 'all' : params['rate_svm']
    end

    def set_charts
      @user_positive = ['Positive', @token.statistics.user_rated_positive, '#337ab7']
      @user_neutral  = ['Neutral',  @token.statistics.user_rated_neutral, '#fcf8e3']
      @user_negative = ['Negative', @token.statistics.user_rated_negative, '#a94442']

      @svm_positive = ['Positive', @token.statistics.svm_rated_positive, '#337ab7']
      @svm_neutral  = ['Neutral',  @token.statistics.svm_rated_neutral, '#fcf8e3']
      @svm_negative = ['Negative', @token.statistics.svm_rated_negative, '#a94442']
    end
  end
end
