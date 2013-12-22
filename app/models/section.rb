class Section < ActiveRecord::Base
  has_many :teams

  validates :name do
    presence
    uniqueness
  end
  validates :display_order do
    presence
    uniqueness
  end

  scope :ordered, -> { reorder('display_order ASC') }
end
