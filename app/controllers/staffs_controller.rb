class StaffsController < ApplicationController
  before_action :set_staff, only: [:show, :verificate]

  # GET /staffs.json
  def index
    @staffs = Staff.ordered
  end

  # GET /staffs/1.json
  def show
  end

  # GET /staffs/1/verificate/:verification_code
  def verificate
    @staff.verificate_with(params[:verification_code])
  end

  # GET /staffs/teams
  def teams
    @staffs = Staff.all
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_staff
    @staff = Staff.find(params[:id])
  end
end
