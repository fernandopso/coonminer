class SitemapController < ApplicationController
  def index
    @tokens = Token.publics
  end
end
