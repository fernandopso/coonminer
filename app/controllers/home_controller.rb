class HomeController < ApplicationController
  layout 'landing'

  def index
    @tokens = Token.active.publics.collect_at_desc.limit(5)
  end
end
