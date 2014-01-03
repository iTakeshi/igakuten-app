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

  # DELETE /shifts/1.json
  def destroy
    shift = Shift.find params[:id]

    shift.destroy!
    render json: { status: :success }
  end

  private
  def shift_params
    params.require(:shift).permit [:participation_id, :period_id]
  end
end
