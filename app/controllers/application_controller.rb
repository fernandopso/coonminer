class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_raven_context

  def set_token
    @token = current_user.tokens.find_by_uuid(params[:token_id])
    if @token.nil?
      redirect_to root_path, notice: t("alerts.not_authorized")
    end
  end

  def set_token_for_public_user
    @token = Token.find_by_uuid(params[:token_id])
    if @token.nil? or @token.private_token?
      unless current_user.present? && current_user.owner?(params[:token_id])
        redirect_to root_path, notice: t("alerts.not_authorized")
      end
    end
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path, notice: t("alerts.not_authorized")
    end
  end

  def prepare_chart(chart)
    chart = [['', Tweet.human_attribute_name(:df)]] + chart
    chart[0..23].push([t("others"), chart[24..-1].map{|k, v| v }.sum]) if chart[23..-1].present?
    chart
  end

  private

  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
