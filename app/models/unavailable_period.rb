class UnavailablePeriod < ActiveRecord::Base
  belongs_to :staff
  belongs_to :period
end
