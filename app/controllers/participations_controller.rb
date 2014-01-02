class ParticipationsController < ApplicationController
  # GET /participations.json
  def index
    @participations = Participation.all
  end

  # GET /participations/manager
  def manager
  end
end
