class MailingList < ActiveRecord::Base
  has_and_belongs_to_many :teams
  has_many :mailing_list_archives

  validates :account_name do
    presence
    uniqueness
  end

  def email
    "#{account_name}@ml.hokudai-igakuten.org"
  end
end
