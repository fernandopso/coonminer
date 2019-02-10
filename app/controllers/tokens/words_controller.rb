module Tokens
  class WordsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_token
    before_action :set_word_id, only: %w[ban restore]

    def index
      @banneds = @token.words.banneds
      @words   = @token.words.actives.order_by_df_desc.paginate(page: params[:page], per_page: 500)
    end

    def banneds
      @banneds = @token.words.banneds
    end

    def ban
      @token.words.find(params[:id]).ban
      @banneds = @token.words.banneds
    end

    def restore
      @token.words.find(params[:id]).active
    end

    private

    def set_word_id
      @word_id = params['word']['word_id']
    end
  end
end
