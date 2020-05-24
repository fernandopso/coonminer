module Admin
  class SamplesController < Admin::ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
      @tokens = Token.disabled.collect_at_asc.five_days_ago
    end

    def update
      @token = Token.find_by_uuid(params[:id])
      @token.revert_enable
      redirect_to token_index_path
    end
  end
end
