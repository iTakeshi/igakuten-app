class StaffsController < ApplicationController
  before_action :set_staff, except: %i(index teams)

  # GET /staffs.json
  def index
    @staffs = Staff.ordered.with_teams
  end

  # GET /staffs/1/verificate/:verification_code
  def verificate
    @staff.verificate_with(params[:verification_code])
  end

  # POST /staffs/1/participate/:team_id.json
  def participate
    @staff.teams << Team.find(params[:team_id])
    render json: { status: :success }
  end

  # POST /staffs/1/unparticipate/:team_id.json
  def unparticipate
    @staff.teams.destroy Team.find(params[:team_id])
    render json: { status: :success }
  end

  private
  def set_staff
    @staff = Staff.find(params[:id])
  end
end
