module Admin
  class ApplicationController < ActionController::Base
    layout 'devise'

    before_action :set_raven_context

    def require_admin
      unless current_user.admin?
        redirect_to root_path, notice: t("alerts.not_authorized")
      end
    end

    private

    def set_raven_context
      Raven.user_context(id: session[:current_user_id]) # or anything else in session
      Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    end
  end
end
