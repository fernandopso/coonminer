class NewslettersController < ApplicationController
  def create
    Newsletter.create(newsletter_params)
  end

  private

  def newsletter_params
    params.require(:newsletter).permit(:email, :token_id)
  end
end
