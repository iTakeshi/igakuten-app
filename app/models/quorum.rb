class Quorum < ActiveRecord::Base
  belongs_to :period
  belongs_to :team

  validates :quorum do
    presence
  end
end
