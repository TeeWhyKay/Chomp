class ChompSessionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.chomp_session_mailer.create_confirmation.subject
  #
  def create_confirmation
    # Might need optimization
    @chomp_session = params[:chomp_session]

    mail(
      to: @chomp_session.user.email,
      subject: "Chomp Session: '#{@chomp_session.name}' is created!"
    )
  end
end
