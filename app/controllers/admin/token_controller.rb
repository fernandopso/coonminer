module Admin
  class TokenController < Admin::ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
      @tokens = Token.active.cron_active.collect_at_asc
    end
  end
end
