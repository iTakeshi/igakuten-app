class Team < ActiveRecord::Base
  belongs_to :section
  has_many :participations, dependent: :destroy
  has_many :staffs, through: :participations
  has_many :shifts, through: :participations
  has_many :quorums, dependent: :destroy
  has_and_belongs_to_many :mailing_lists

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
