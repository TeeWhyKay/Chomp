# Preview all emails at http://localhost:3000/rails/mailers/chomp_session_mailer
class ChompSessionMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/chomp_session_mailer/creation_confirmation
  def creation_confirmation
    ChompSessionMailer.creation_confirmation
  end

end
