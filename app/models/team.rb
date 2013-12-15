class Team < ActiveRecord::Base
  belongs_to :section

  validates :name do
    presence
    uniqueness
  end
end
