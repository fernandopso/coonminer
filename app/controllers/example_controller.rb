class ExampleController < ApplicationController
  def index
    redirect_to token_mining_index_path(token.uuid)
  end

  private

  def token
    Token.publics.collect_at_desc.limit(5).sample
  end
end
