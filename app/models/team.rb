class Team < ActiveRecord::Base
  belongs_to :section
  has_and_belongs_to_many :staffs
  has_many :quorums

  validates :name do
    presence
    uniqueness
  end
end
