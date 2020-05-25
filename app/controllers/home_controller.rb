class HomeController < ApplicationController
  layout 'landing'

  def index
    @token = Token.active.publics.collect_at_desc.limit(5).sample
  end
end
