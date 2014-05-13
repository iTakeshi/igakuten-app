class MailingListMailer < ActionMailer::Base
  self.smtp_settings = {
    address:   'smtp.mandrillapp.com',
    port:      587,
    user_name: Figaro.env.ml_smtp_user,
    password:  Figaro.env.ml_smtp_pass
  }

  def publication(to_addresses, ml_email, sender_name, sender_email, message_subject, message_body)
    @ml_email = ml_email
    @sender_name = sender_name
    @sender_email = sender_email
    @message_body = message_body

    mail to: sender_email, bcc: to_addresses, from: ml_email, reply_to: sender_email, subject: message_subject
  end
end
