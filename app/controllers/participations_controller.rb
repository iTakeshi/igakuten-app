class ParticipationsController < ApplicationController
  # GET /participations.json
  def index
    @participations = Participation.all
  end

  # POST /participations.json
  def create
    participation = Participation.new participation_params

    if participation.save
      render json: { status: :success, participation: participation }
    else
      render json: { status: :error, errors: participation.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /participations/1.json
  def destroy
    participation = Participation.find params[:id]

    participation.destroy!
    render json: { status: :success }
  end

  # GET /participations/manager
  def manager
  end

  private
  def participation_params
    params.require(:participation).permit [:team_id, :staff_id]
  end
end
