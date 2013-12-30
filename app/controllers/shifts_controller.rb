class ShiftsController < ApplicationController
  # GET /shifts.json
  def index
    @shifts = Shift.all
  end

  # GET /shifts/designer
  def designer
  end
end
