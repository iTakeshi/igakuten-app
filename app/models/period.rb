class Period < ActiveRecord::Base
  belongs_to :festival_date
  has_many :quorums
  has_many :shifts
  has_many :working_staffs, through: :shifts, source: :staff
  has_many :unavailable_periods
  has_many :recessing_staffs, through: :unavailable_periods, source: :staff

  validates :begins_at do
    presence
  end
  validates :ends_at do
    presence
  end

  default_scope { includes(:festival_date) }
  scope :ordered, -> { reorder('festival_dates.day ASC, begins_at ASC') }

  def to_s
    "#{self.festival_date.day}日目 #{self.begins_at.strftime('%H:%M')} - #{self.ends_at.strftime('%H:%M')}"
  end
end
