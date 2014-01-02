class Shift < ActiveRecord::Base
  belongs_to :participation
  belongs_to :period

  validates :participation_id do
    presence
    uniqueness scope: :period_id
  end
  validates :period_id do
    presence
  end
end
