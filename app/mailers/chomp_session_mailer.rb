class ChompSessionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.chomp_session_mailer.create_confirmation.subject
  #
  def create_confirmation
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
