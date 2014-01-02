class ParticipationsController < ApplicationController
  # GET /participations.json
  def index
    @participations = Participation.all
  end
end
