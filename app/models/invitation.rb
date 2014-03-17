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

  def exec
    # WIP
  end
end
