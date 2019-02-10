module Admin
  class RatesController < Admin::ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
      @tokens = Token.active.order_by_word
    end
  end
end
