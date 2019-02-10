# frozen_string_literal: true

class TokensController < ApplicationController
  layout 'devise', only: %w[index new]

  before_action :authenticate_user!
  before_action :require_admin, only: %w[privacity publish category]

  before_action :can_create_token, only: %w[new create]

  def index
    @tokens = current_user.tokens.collect_at_desc
  end

  def new
    @token = Token.new
  end

  def create
    @token = current_user.tokens.build(token_params.merge(collect_at: DateTime.current))
    if @token.save
      SampleWorker.perform_async(@token.id)
      redirect_to token_collect_index_path(@token.uuid)
    else
      render :new
    end
  end

  def privacity
    token = Token.find_by_uuid(params[:id])
    token.revert_privacity
    @tokens = Filter::Tokens.new(Token.all, params).sort_tokens
  end

  def destroy
    token = current_user.tokens.find_by_uuid(params[:id])

    if token.nil? and current_user.admin?
      token = Token.find_by_uuid(params[:id])
    end

    token.revert_enable

    if token.enable
      redirect_to token_collect_index_path(token.uuid)
    else
      redirect_to tokens_path
    end
  end

  def publish
    token = Token.find_by_uuid(params[:id])
    token.revert_publishable
    @tokens = Filter::Tokens.new(Token.all, params).sort_tokens
  end

  def language
    token = current_user.tokens.find_by_uuid(params[:id])
    token.update(lang: token_params["lang"])
  end

  def category
    @token = Token.find_by_uuid(params[:id])
    @token.update(category_id: token_params[:category_id])
  end

  private

  def token_params
    params.require(:token).permit(:word, :lang, :category_id, :username, :avatar).merge(company_id: current_user.company.id)
  end

  def can_create_token
    unless current_user.admin? || current_user.create_token?
      redirect_to tokens_path, notice: t("alerts.free_account", max: Company::MAX_TOKENS)
    end
  end
end
