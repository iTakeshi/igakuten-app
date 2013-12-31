class ShiftsController < ApplicationController
  # GET /shifts.json
  def index
    @shifts = Shift.all
  end

  # POST /shifts.json
  def create
    shift = Shift.new shift_params

    if shift.save
      render json: { status: :success, shift: shift }
    else
      render json: { status: :error, errors: shift.errors }, status: :unprocessable_entity
    end
  end

  # GET /shifts/designer
  def designer
  end

  private
  def shift_params
    params.require(:shift).permit([:period_id, :team_id, :staff_id])
  end
end
