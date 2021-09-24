class ChompSessionMailer < ApplicationMailer
  before_action :set_chomp_session

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.chomp_session_mailer.create_chomp.subject
  #
  def create_chomp
    mail(
      to: @chomp_session.user.email,
      subject: "Chomp Session: '#{@chomp_session.name}' is created!"
    )
  end

  def update_chomp
    mail(
      to: @chomp_session.user.email,
      subject: "Chomp Session: '#{@chomp_session.name}' is updated!"
    )
  end

  private

  def set_chomp_session
    @chomp_session = params[:chomp_session]
  end
end
