class ChompSessionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.chomp_session_mailer.create_chomp.subject
  #
  def create_chomp
    @chomp_session = params[:chomp_session]

    mail(
      to:       @chomp_session.user.email,
      subject:  "Chomp Session: '#{@chomp_session.name}' is created!"
    )
  end

  def update_chomp
    @chomp_session = params[:chomp_session]

    mail(
      to:       @chomp_session.user.email,
      subject:  "Chomp Session: '#{@chomp_session.name}' is updated!"
    )
  end
end
