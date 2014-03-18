class Invitation < ActiveRecord::Base
  validates :email do
    presence
    uniqueness
    format with: /[^\s@]+@[^\s@]+/
  end

  validates :invitation_code do
    presence
    uniqueness
  end

  before_validation :set_invitation_code

  after_create :send_invitation_mail

  def send_invitation_mail
    StaffInvitor.invitation(self).deliver
  end

  private

  def set_invitation_code
    begin
      code = SecureRandom.hex(10)
    end while Invitation.exists?(invitation_code: code)
    self.invitation_code = code
  end
end
