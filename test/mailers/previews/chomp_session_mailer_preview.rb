# Preview all emails at http://localhost:3000/rails/mailers/chomp_session_mailer
class ChompSessionMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/chomp_session_mailer/create_confirmation
  def create_confirmation
    ChompSessionMailer.create_confirmation
  end

end
