class MailingListArchive < ActiveRecord::Base
  belongs_to :mailing_list
  belongs_to :staff

  def publish
    to_addresses = self.mailing_list.staffs.map(&:email).uniq

    MailingListMailer.default(
      to_addresses,
      self.mailing_list.email,
      self.staff.full_name,
      self.staff.email,
      self.subject,
      self.body
    ).deliver
  end
end
