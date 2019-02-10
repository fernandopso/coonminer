module Admin
  class NewsletterController < Admin::ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
      @newsletters = Newsletter.all
    end
  end
end
