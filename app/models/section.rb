class Section < ActiveRecord::Base
  validates :name do
    presence
    uniqueness
  end
end
