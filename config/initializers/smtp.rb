ActionMailer::Base.smtp_settings = {
  address: "smtp.eu.mailgun.org",
  port: 587,
  domain: 'letschomp.co',
  user_name: ENV['MAILGUN_LOGIN'],
  password: ENV['MAILGUN_PASSWORD'],
  authentication: :plain
}
