module Admin
  class TokenController < Admin::ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
      @tokens = Token.cron_active.collect_at_asc.includes([:metric])
    end
  end
end
