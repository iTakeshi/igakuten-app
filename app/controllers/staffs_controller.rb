class StaffsController < ApplicationController
  before_action :set_staff, except: %i(index teams)

  # GET /staffs.json
  def index
    @staffs = Staff.ordered
  end

  # GET /staffs/1/verificate/:verification_code
  def verificate
    @staff.verificate(params[:verification_code])
  end

  private
  def set_staff
    @staff = Staff.find(params[:id])
  end
end
