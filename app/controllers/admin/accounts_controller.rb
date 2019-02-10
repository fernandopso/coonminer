module Admin
  class AccountsController < Admin::ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def update_all
      Token.active.each do |token|
        if token.username.present?
          token.update(avatar: client.user(token.username).profile_image_url.to_s)
        end
      end

      redirect_to rates_path
    end

    private

    def client
      CoonMiner.twitter_client
    end
  end
end
