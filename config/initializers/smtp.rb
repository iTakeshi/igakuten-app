IgakutenApp::Application.configure do
  if Rails.env == 'production'
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: 'smtp-mail.outlook.com',
      port: 25,
      enable_starttls_auto: true,
      authentification: :plain,
      user_name: Figaro.env.smtp_user,
      password: Figaro.env.smtp_pass
    }
  end
end
