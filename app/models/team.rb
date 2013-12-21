class Team < ActiveRecord::Base
  belongs_to :section
  has_and_belongs_to_many :staffs
  has_many :quorums
  has_many :shifts

  validates :name do
    presence
    uniqueness
  end

  default_scope { includes(:section) }
  scope :ordered, -> { reorder('sections.display_order ASC, teams.display_order ASC') }
end
