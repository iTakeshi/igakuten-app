class Quorum < ActiveRecord::Base
  belongs_to :period
  belongs_to :team

  validates :period_id do
    uniqueness scope: :team_id
  end
  validates :quorum do
    presence
  end
end
