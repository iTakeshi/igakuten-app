IgakutenApp::Application.configure do
  if Rails.env == 'production'
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: 'smtp.mandrillapp.com',
      port: 587,
      user_name: Figaro.env.smtp_user,
      password: Figaro.env.smtp_pass
    }
  end
end
