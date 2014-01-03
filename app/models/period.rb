class Period < ActiveRecord::Base
  belongs_to :festival_date
  has_many :quorums, dependent: :destroy
  has_many :shifts, dependent: :destroy
  has_many :participations, through: :shifts
  has_many :staffs, through: :participations

  validates :begins_at do
    presence
    uniqueness
  end
  validates :ends_at do
    presence
    uniqueness
  end

  default_scope { includes(:festival_date).references(:festival_date) }
  scope :ordered, -> { reorder('festival_dates.day ASC, begins_at ASC') }

  def initialize(attributes = {}, options = {})
    super

    if self.festival_date
      self.begins_at ||= festival_date.date
      self.ends_at ||= festival_date.date
    end
  end

  after_create do
    Team.all.each do |team|
      Quorum.create period: self,
                    team: team,
                    quorum: 0
    end
  end

  def to_s
    "#{self.festival_date.day}日目 #{self.begins_at.strftime('%H:%M')} - #{self.ends_at.strftime('%H:%M')}"
  end

  def time
    "#{self.begins_at.strftime('%H:%M')} - #{self.ends_at.strftime('%H:%M')}"
  end
end
