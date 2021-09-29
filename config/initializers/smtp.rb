ActionMailer::Base.smtp_settings = {
  address: "smtp.mailgun.org",
  port: 587,
  domain: 'letschomp.co',
  user_name: ENV['MAILGUN_LOGIN'],
  password: ENV['MAILGUN_PASSWORD'],
  authentication: :login,
  enable_starttls_auto: true
}
