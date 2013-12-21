class Quorum < ActiveRecord::Base
  belongs_to :period
  belongs_to :team

  validates :period_id do
    uniqueness scope: :team_id
  end
  validates :quorum do
    presence
    numericality only_integer: true,
                 greater_than_or_equal_to: 0,
                 less_than_or_equal_to: 20
  end
end
