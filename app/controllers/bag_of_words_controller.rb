class BagOfWordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_token

  def create
    @token.bag_of_word.ban_word(bag_of_word_params[:word])
    @banned_words = @token.bag_of_word.banned
    @word_id = bag_of_word_params[:word_id]
  end

  private

  def bag_of_word_params
    params.require(:bag_of_word).permit(:word, :word_id)
  end

end
