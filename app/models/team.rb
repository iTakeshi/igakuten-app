class Team < ActiveRecord::Base
  belongs_to :section
  has_many :participations
  has_many :staffs, through: :participations
  has_many :shifts, through: :participations
  has_many :quorums

  validates :name do
    presence
    uniqueness
  end
  validates :display_order do
    presence
    uniqueness scope: :section_id
  end

  default_scope { includes(:section).references(:section) }
  scope :ordered, -> { reorder('sections.display_order ASC, teams.display_order ASC') }

  after_create do
    Period.all.each do |period|
      Quorum.create period: period,
                    team: self,
                    quorum: 0
    end
  end
end
