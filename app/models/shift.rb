class Shift < ActiveRecord::Base
  belongs_to :period
  belongs_to :team
  belongs_to :staff
end
