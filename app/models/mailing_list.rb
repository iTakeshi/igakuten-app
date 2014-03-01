class MailingList < ActiveRecord::Base
  validates :account_name do
    presence
    uniqueness
  end
end
