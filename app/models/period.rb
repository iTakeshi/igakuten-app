class Period < ActiveRecord::Base
  belongs_to :festival_date
  has_many :quorums
  has_many :shifts

  validates :begins_at do
    presence
  end
  validates :ends_at do
    presence
  end
end
