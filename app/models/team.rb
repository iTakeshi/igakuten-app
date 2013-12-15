class Team < ActiveRecord::Base
  belongs_to :section
  has_many :quorums

  validates :name do
    presence
    uniqueness
  end
end
