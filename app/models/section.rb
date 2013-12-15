class Section < ActiveRecord::Base
  has_many :teams

  validates :name do
    presence
    uniqueness
  end
end
