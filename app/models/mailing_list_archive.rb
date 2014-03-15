class MailingListArchive < ActiveRecord::Base
  belongs_to :mailing_list
  belongs_to :staff
end
