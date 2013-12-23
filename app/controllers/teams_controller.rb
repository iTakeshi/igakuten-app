class TeamsController < ApplicationController
  before_action :set_team, only: [:show]

  # GET /teams.json
  def index
    @teams = Team.ordered
  end

  # GET /teams/1.json
  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.find(params[:id])
  end
end
