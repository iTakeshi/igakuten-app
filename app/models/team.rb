class Team < ActiveRecord::Base
  belongs_to :section
  has_and_belongs_to_many :staffs
  has_many :quorums
  has_many :shifts

  validates :name do
    presence
    uniqueness
  end
  validates :display_order do
    presence
    uniqueness scope: :section_id
  end

  default_scope { includes(:section) }
  scope :ordered, -> { reorder('sections.display_order ASC, teams.display_order ASC') }

  after_create do
    Period.all.each do |period|
      Quorum.create period: period,
                    team: self,
                    quorum: 0
    end
  end
end
