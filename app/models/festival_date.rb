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
end
