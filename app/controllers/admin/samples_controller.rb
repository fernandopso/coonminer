module Admin
  class SamplesController < Admin::ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
      @tokens = Token.disabled.collect_at_asc.five_days_ago
    end
  end
end
