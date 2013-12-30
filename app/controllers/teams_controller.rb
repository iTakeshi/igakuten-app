class TeamsController < ApplicationController
  # GET /teams.json
  def index
    @teams = Team.ordered
  end
end
