class FestivalDate < ActiveRecord::Base
  has_many :periods

  validates :day do
    presence
    uniqueness
    numericality only_integer: true,
                 greater_than_or_equal_to: 1,
                 less_than_or_equal_to: 4
  end
  validates :date do
    presence
    uniqueness
  end

  scope :ordered, -> { reorder('day ASC') }

  def to_s
    "#{self.date} （#{self.day}日目）"
  end
end
