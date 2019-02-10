class SitemapController < ApplicationController
  def index
    @tokens = Token.publics.active
  end
end
