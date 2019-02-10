# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  layout 'devise'

  def users
    @users = User.current_sign_in_at_desc
  end

  def publish
    @tokens = Filter::Tokens.new(Token.all, params).sort_tokens
  end
end
