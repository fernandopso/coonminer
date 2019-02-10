class SettingsController < ApplicationController
  layout "devise"

  before_action :authenticate_user!

  def index
  end
end
