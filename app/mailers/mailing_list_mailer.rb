class MailingListMailer < ActionMailer::Base
  def default(to_addresses, ml_email, sender_name, sender_email, subject, body)
    @ml_email = ml_email
    @sender_name = sender_name
    @sender_email = sender_email
    @body = body

    delivery_options = {
      user_name: Figaro.env.ml_smtp_user,
      password: Figaro.env.ml_smtp_pass
    }
    mail to: to_addresses, from: ml_email, reply_to: sender_email, subject: subject
  end
end
