class MailingList < ActiveRecord::Base
  has_and_belongs_to_many :teams

  validates :account_name do
    presence
    uniqueness
  end
end
