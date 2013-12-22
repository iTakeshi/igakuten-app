class UnavailablePeriod < ActiveRecord::Base
  belongs_to :staff
  belongs_to :period

  validates :staff_id do
    presence
    uniqueness scope: :period_id
  end
  validates :period_id do
    presence
  end
end
