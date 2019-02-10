module Tokens
  class CollectController < ApplicationController
    before_action :authenticate_user!
    before_action :set_token

    before_action :require_admin, only: :cron

    def cron
      @token.revert_keep_cron_crawler
    end
  end
end
