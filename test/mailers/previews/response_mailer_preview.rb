# Preview all emails at http://localhost:3000/rails/mailers/response_mailer
class ResponseMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/response_mailer/create_response
  def create_response
    ResponseMailer.create_response
  end

  # Preview this email at http://localhost:3000/rails/mailers/response_mailer/update_response
  def update_response
    ResponseMailer.update_response
  end

end
