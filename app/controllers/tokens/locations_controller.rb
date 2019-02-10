module Tokens
  class LocationsController < ApplicationController
    before_action :set_token_for_public_user
    before_action :set_locations
    before_action :set_chart_options

    def index
    end

    private

    def set_locations
      @locations = Filter::Tweets.new(@token, params).locations
    end

    def set_chart_options
      @chart_options = prepare_chart(options_for_chart)
    end

    def options_for_chart
      @locations.pluck :name, :df
    end
  end
end
