class StaffsController < ApplicationController
  skip_before_filter :authenticate, only: %i(verificate invite create)

  before_action :set_staff, except: %i(index teams invite create)

  # GET /staffs.json
  def index
    @staffs = Staff.ordered
  end

  # GET /staffs/1/verificate/:verification_code
  def verificate
    @staff.verificate(params[:verification_code])
  end

  # GET /staffs/invite/:invitation_code
  def invite
    invitation = Invitation.find_by(invitation_code: params[:invitation_code])
    @staff = Staff.new(email: invitation.email)
    @invitation_code = invitation.invitation_code
  end

  def create
    invitation = Invitation.find_by(email: params[:staff][:email])
    if invitation.invitation_code != params[:invitation_code]
      raise
    end

    @staff = Staff.new(staff_params)
    @staff.provisional = true
    if @staff.save
      render
    else
      render action: :invite
    end
  end

  private
  def set_staff
    @staff = Staff.find(params[:id])
  end

  def staff_params
    params.require(:staff).permit(:family_name, :given_name, :family_name_yomi, :given_name_yomi, :gender, :grade, :email, :phone)
  end
end
