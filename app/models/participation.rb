class Participation < ActiveRecord::Base
  belongs_to :team
  belongs_to :staff
  has_many :shifts, dependent: :destroy
  has_many :periods, through: :shifts

  validates :team_id do
    presence
    uniqueness scope: :staff_id
  end
  validates :staff_id do
    presence
  end
end
