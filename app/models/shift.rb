class Shift < ActiveRecord::Base
  belongs_to :period
  belongs_to :team
  belongs_to :staff

  validates :period_id do
    presence
    uniqueness scope: :staff_id
  end
  validates :team_id do
    presence
  end
  validates :staff_id do
    presence
  end
  validates_with StaffMustParticipatesInTheTeamValidator
end
