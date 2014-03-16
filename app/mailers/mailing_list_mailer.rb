class MailingListMailer < ActionMailer::Base
  after_action :set_delivery_options

  def publication(to_addresses, ml_email, sender_name, sender_email, subject, body)
    @ml_email = ml_email
    @sender_name = sender_name
    @sender_email = sender_email
    @body = body

    mail to: to_addresses, from: ml_email, reply_to: sender_email, subject: subject
  end

  private

  def set_delivery_options
    mail.delivery_method.settings.merge!({
      user_name: Figaro.env.ml_smtp_user,
      password: Figaro.env.ml_smtp_pass
    })
  end
end
