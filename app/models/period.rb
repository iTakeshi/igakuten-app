class Period < ActiveRecord::Base
  belongs_to :festival_date

  validates :begins_at do
    presence
  end
  validates :ends_at do
    presence
  end
end
