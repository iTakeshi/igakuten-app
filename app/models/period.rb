class Period < ActiveRecord::Base
  belongs_to :festival_date
  has_many :quorums
  has_many :shifts
  has_many :working_staffs, through: :shifts, source: :staffs
  has_many :unavailable_periods
  has_many :recessing_staffs, through: :unavailable_periods, source: :staffs

  validates :begins_at do
    presence
  end
  validates :ends_at do
    presence
  end
end
