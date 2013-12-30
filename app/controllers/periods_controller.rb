class PeriodsController < ApplicationController
  # GET /periods.json
  def index
    @periods = Period.ordered
  end
end
